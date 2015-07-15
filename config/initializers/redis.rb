url = URI.parse(ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/events-insider')

$redis = Redis.new(url: url, driver: :hiredis)