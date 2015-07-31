Geocoder.configure(
  timeout:    3,           # geocoding service timeout (secs)
  lookup:     :google,     # name of geocoding service
  ip_lookup:  :freegeoip,    # name of ip lookup service
  language:   :en,         # ISO-639 language code
  cache:      $redis,

  units: :mi,
  distances: :spherical,

  google: {
    api_key: nil
  },

  maxmind: {
    service: :city
  }

  # :use_https    => false,       # use HTTPS for lookup requests? (if supported)
  # :http_proxy   => nil,         # HTTP proxy server (user:pass@host:port)
  # :https_proxy  => nil,         # HTTPS proxy server (user:pass@host:port)

  # exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and TimeoutError
  # :always_raise => [],
)
