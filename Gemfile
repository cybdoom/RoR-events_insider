source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.2.3'

gem 'pg'

# Main gems
gem 'devise'
gem 'fast_blank'
gem 'hiredis'
gem 'jbuilder', '~> 2.0'
gem 'pundit'
gem 'seed_migration'
gem 'simple_form'
gem 'redis', require:  ['redis', 'redis/connection/hiredis']

# Front-end gems
gem 'bourbon'
gem 'neat'
gem 'sass-rails', '~> 5.0'
gem 'compass-import-once', require: 'compass/import-once/activate'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'twitter-typeahead-rails'

group :production do
  gem 'puma'
  gem 'rails_12factor'
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