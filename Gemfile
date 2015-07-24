source 'https://rubygems.org'

ruby '2.1.6'

gem 'rails', '4.2.3'

gem 'pg'
gem 'postgres_ext'

# Main gems
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'countries'
gem 'devise'
gem 'fast_blank'
gem 'fixme', github: 'henrik/fixme'
gem 'geocoder'
gem 'highline', require: false
gem 'hiredis'
gem 'indirizzo', github: 'pineapplethief/indirizzo', branch: 'master' # US address parsing
gem 'jbuilder', '~> 2.0'
gem 'kgio'
gem 'pundit'
gem 'pry-rails'
gem 'rack-cache'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'redis-store'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'require_all'
gem 'seed_migration'
gem 'simple_enum'
gem 'simple_form'

# Front-end gems
gem 'coffee-rails', '~> 4.1.0'
gem 'bourbon'
gem 'jquery-rails'
gem 'neat'
gem 'sass-rails', '~> 5.0'
gem 'twitter-typeahead-rails'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'heroku-deflater'
  gem 'rack-timeout'
end

group :development do
  gem 'annotate', '~> 2.6.6'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano-rails'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc