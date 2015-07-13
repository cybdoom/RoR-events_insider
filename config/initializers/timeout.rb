# There is no request timeout mechanism inside of Puma.
# The Heroku router will timeout all requests that exceed 30 seconds.
# Although an error will be returned back to the client, Puma will continue to work
# on the request as there is no way for the router to notify Puma that the request
# terminated early. To avoid clogging your processing ability we recommend using
# Rack::Timeout to terminate long running requests and locate their source.
#
# More info: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
#
if defined?(Rack::Timeout)
  Rack::Timeout.timeout = 10 # seconds
end