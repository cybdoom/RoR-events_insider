module Service

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  module InstanceMethods
  end

end