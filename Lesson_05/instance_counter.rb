module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.instance_variable_set :@instances_count, 0
  end

  module ClassMethods
    def instances
      @instances_count
    end
  end

  module InstanceMethods
    def register_instance
      current = self.class.instance_variable_get(:@instances_count)
      self.class.instance_variable_set(:@instances_count, current.succ)
    end
  end
end
