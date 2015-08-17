require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

platform = RUBY_PLATFORM.match(/(linux|darwin)/)[0].to_sym
Bundler.require(platform)

module EventsInsider
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    require_all "#{Rails.root}/lib/extensions"
    require_all "#{Rails.root}/lib/logging" if !Rails.env.production?
    require_all "#{Rails.root}/lib/carrierwave"
    require_all "#{Rails.root}/lib/virtus"
    require_all "#{Rails.root}/lib/devise"

    config.active_record.schema_format = :sql

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.cache_store = :redis_store, ENV.fetch('REDIS_URL'),
                         {namespace: 'evin_cache_store', expires_in: 1.day, compress: true}

  end
end
