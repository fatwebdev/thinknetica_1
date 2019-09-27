# frozen_string_literal: true

module Accessors
  def self.insluded(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |name|
        var_name = "@#{name}".to_sym

        define_method("#{name}=".to_sym) do |value|
          new_value = (instance_variable_get(var_name) || []) << value
          instance_variable_set(var_name, new_value)
        end

        define_method(name) { (instance_variable_get(var_name) || []).last }

        define_method("#{name}_history".to_sym) { instance_variable_get(var_name) || [] }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym

      define_method("#{name}=".to_sym) do |value|
        raise "you can assign only #{type} instances" unless value.is_a? type

        instance_variable_set(var_name, value)
      end

      define_method(name) { instance_variable_get(var_name) }
    end
  end
end
