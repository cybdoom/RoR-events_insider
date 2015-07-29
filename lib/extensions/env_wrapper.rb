require_relative 'to_boolean'
# Delegator to convert strings to boolean values in ENV hash
class EnvWrapper < SimpleDelegator

  def [](key)
    value = super
    value = value.to_bool if value == 'true' || value == 'false'
    value
  end

end

# wrap ENV hash-like object into delegator and assign without interpreter warnings
silence_warnings { ENV = EnvWrapper.new(ENV) }
