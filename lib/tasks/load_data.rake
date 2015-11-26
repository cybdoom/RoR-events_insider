require 'pathname'

namespace :db do
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

  def parse_data_file path, blog_id
    articles = []
    new_article = {}
    reading_body = false
    body = ''
    File.foreach(path) do |line|
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
        new_article[key.downcase.to_sym] = line.split(':')[1].strip
      end
    end
    articles
  end

  def create_blogs
    mask = File.join Rails.root, 'db', 'blogs', '**'
    @files = Dir[mask].select {|entry| File.file? entry }
    @files.each do |path|
      title = Pathname.new(path).basename.to_s.split('.').first
      Blog.create(title: title, author: 'Johnny Monsarrat')
    end
  end

  def load_articles
    @files.each do |path|
      title = Pathname.new(path).basename.to_s.split('.').first
      articles = parse_data_file path, Blog.where(title: title).first.id
      Article.create articles
    end
  end

  desc 'Loads data from db/blogs Moveable Type files'
  task load_data: :environment do
    create_blogs
    load_articles
  end
end
