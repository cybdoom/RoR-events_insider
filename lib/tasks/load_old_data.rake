require 'pathname'

namespace :db do
  BLOGS_BUCKET = 'eventsinsider-harddatafactory-dev'

  def valid_article? article
    article[:date].present? && article[:title].present? && article[:body].present?
  end

  def sanitize_from_html article
    body = Nokogiri::HTML(article[:body])
    article[:body] = Nokogiri::HTML(article[:body]).inner_text
    article[:title] = Nokogiri::HTML(article[:title]).inner_text
    begin
      article[:created_at] = article[:updated_at] = DateTime.parse(article[:date])
      article.delete :date
    rescue
      article[:date] = nil
    end
    article
  end

  def parse_data_file lines, blog_id
    articles = []
    new_article = {}
    reading_body = false
    body = ''
    lines.each do |line|
      next if line.nil?

      if line.strip == '--------'
        new_article[:blog_id] = blog_id
        articles << sanitize_from_html(new_article) if valid_article?(new_article)
        new_article = {}
        next
      end

      key = line.split(':').first

      if key == 'BODY'
        reading_body = true
        next
      end

      if reading_body
        if line.strip == '-----'
          reading_body = false
          new_article[:body] = body
          body = ''
        else
          body += line
        end
        next
      end

      if ['TITLE', 'DATE'].include? key
        new_article[key.downcase.to_sym] = line.split(':')[1].nil? ? '' : line.split(':')[1].strip
      end
    end

    articles
  end

  desc 'Loads data from db/blogs Moveable Type files'
  task load_old_data: :environment do
    def read_files
      result = {}
      if Rails.env.production? || ENV['LOAD_OLD_DATA']
        s3 = AWS::S3.new
        bucket = s3.buckets[BLOGS_BUCKET]
        bucket.objects.each do |object|
          key = object.key
          if key.split('.').last == 'txt'
            blog_title = key.split('/').last.split('.').first
            lines = object.read.split("\n")
            yield blog_title, lines
          end
        end
      else
        mask = File.join Rails.root, 'db', 'blogs', '**'
        files = Dir[mask].select {|path| File.file?(path) }
        files.each do |file_name|
          lines = nil
          File.open(file_name, 'r') {|file| lines = file.readlines }
          blog_title = Pathname.new(file_name).basename.to_s.split('.').first
          yield blog_title, lines
        end
      end
      result
    end

    if ENV['ERASE_OLD']
      Blog.destroy_all
      Article.destroy_all
    end

    read_files do |blog_title, lines|
      blog = Blog.create(title: blog_title, author: 'Johnny Monsarrat')
      Article.create parse_data_file(lines, blog.id)
    end
  end
end
