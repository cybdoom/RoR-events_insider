CarrierWave.configure do |config|
  storage = Rails.env.production? ? :fog : :file
  config.storage = storage
  config.cache_storage = storage

  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Configuration for Amazon AWS
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
    }
    config.fog_directory = ENV.fetch('AWS_BUCKET')
  end

end