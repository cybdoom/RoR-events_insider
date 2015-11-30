source 'https://rubygems.org'

ruby '2.1.6'

gem 'dotenv-rails', groups: [:development, :test]

gem 'rails', '4.2.3'

gem 'pg'
gem 'postgres_ext'
gem 'schema_plus'

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'carrierwave-aws'
gem 'colorize'
gem 'countries'
gem 'date_validator'
gem 'faraday', github: 'lostisland/faraday'
gem 'faraday_middleware', github: 'lostisland/faraday_middleware'
gem 'fast_blank'
gem 'fixme', github: 'henrik/fixme'
gem 'geocoder'
gem 'highline', require: false
gem 'hiredis'
gem 'indirizzo', github: 'pineapplethief/indirizzo', branch: 'master' # US address parsing
gem 'jbuilder', '~> 2.0'
gem 'kgio'
gem 'mini_magick'
gem 'pry-rails'
gem 'pundit'
gem 'rack-cache'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'redis-rails'
gem 'require_all'
gem 'responders'
# gem 'ruby-filemagic'#, path: 'vendor/gems/ruby-filemagic-0.7.0'
gem 'seed_migration'
gem 'simple_enum'
gem 'simple_form'
gem 'typhoeus'
gem 'virtus'
gem 'activeadmin', github: 'activeadmin'
gem 'kaminari'

# Front-end gems
gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.1.0'
gem 'bootstrap-daterangepicker-rails'
gem 'bourbon'
gem 'gmaps4rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'neat'
gem 'momentjs-rails'
gem 'sassc-rails'
gem 'twitter-typeahead-rails'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'heroku-deflater'
  gem 'puma'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :development do
  gem 'annotate', '~> 2.6.6'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano-rails'
  gem 'guard-livereload', '~> 2.4', require: false
  gem 'libnotify'
  gem 'rack-livereload', github: 'johnbintz/rack-livereload'
  gem 'rb-fsevent', group: :darwin, require: false
  gem 'rb-inotify', group: :linux, require: false
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
  gem 'show_data'
  # gem 'spring'
  gem 'web-console', '~> 2.0'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
