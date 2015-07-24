require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EventsInsider
  class Application < Rails::Application
    require_all "#{Rails.root}/lib/core_extensions"
    require_all "#{Rails.root}/lib/carrierwave"

    config.active_record.schema_format = :sql

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    redis_url = ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/events-insider'

    config.cache_store = :redis_store, redis_url,
                         {namespace: 'evin_cache_store', expires_in: 1.day, compress: true}

  end
end
