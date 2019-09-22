module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.instance_variable_set :@instances, 0
  end

  module ClassMethods
    def instances
      @instances
    end

    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end
end
