# Delegator to convert strings to boolean values in ENV hash
module EnvBooleans
  class EnvWrapper < SimpleDelegator
    def [](key)
      value = super
      value_string = value.to_s.downcase
      value = EnvBooleans.to_bool(value_string) if value_string == 'true' || value_string == 'false'
      value
    end

    def fetch(key)
      value = super
      value_string = value.to_s.downcase
      value = EnvBooleans.to_bool(value_string) if value_string == 'true' || value_string == 'false'
      value
    end
  end

  def self.silence_warnings
    old_verbose = $VERBOSE
    $VERBOSE = nil
    yield
  ensure
    $VERBOSE = old_verbose
  end

  private

  def self.to_bool(string)
    string == 'true'
  end

end

EnvBooleans.silence_warnings { ENV = EnvBooleans::EnvWrapper.new(ENV) }