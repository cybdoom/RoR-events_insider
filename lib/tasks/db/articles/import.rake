require 'pathname'

namespace :db do
  namespace :articles do
    desc 'Loads old blogs data from db/blogs Moveable Type files or from AWS bucket'
    task import: :environment do
      BLOGS_BUCKET = 'eventsinsider-harddatafactory-dev'
      KEYS_REGEXPS = {
        title:   /\ATITLE:(.*)/,
        author:  /\AAUTHOR:(.*)/,
        date:    /\ADATE:(.*)/,
        body:    /\ABODY:(.*)/
      }.freeze

      def valid_article? article
        article[:date].present? && article[:title].present? && article[:body].present? && article[:author].present?
      end

      def sanitize_from_html article
        # body = Nokogiri::HTML(article[:body])
        # article[:body] = Nokogiri::HTML(article[:body]).inner_text
        # article[:title] = Nokogiri::HTML(article[:title]).inner_text
        begin
          article[:created_at] = article[:updated_at] = DateTime.parse(article[:date])
          article.delete :date
        rescue
          article[:date] = nil
        end
        article
      end

      def parse_data_file lines
        articles = []
        new_article = {}
        reading_body = false
        body = ''
        lines.each do |line|
          next if line.nil?

          if line.strip == '--------'
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

          KEYS_REGEXPS.each { |key, regexp|  new_article[key] = $1 if regexp.match(line) }
        end

        articles
      end

      def read_files
        result = {}
        if Rails.env.production? || ENV['FROM_AWS']
          s3 = AWS::S3.new
          bucket = s3.buckets[BLOGS_BUCKET]
          bucket.objects.each do |object|
            key = object.key
            if key.split('.').last == 'txt'
              lines = object.read.split("\r\n").map {|line| "#{line}\r\n" }
              yield lines
            end
          end
        else
          mask = File.join Rails.root, 'db', 'blogs', '**'
          files = Dir[mask].select {|path| File.file?(path) }
          files.each do |file_name|
            lines = nil
            File.open(file_name, 'r') {|file| lines = file.readlines }
            yield lines
          end
        end
        result
      end

      if ENV['REWRITE']
        Article.destroy_all
      end

      read_files {|lines| Article.create parse_data_file(lines) }
    end
  end
end
