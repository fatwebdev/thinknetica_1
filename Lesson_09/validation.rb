# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, *args)
      @validates ||= []
      @validates << { name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |condition|
        condition.each do |name, params|
          value = instance_variable_get("@#{name}".to_sym)
          validator, *args = params

          send validator, name, value, args
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def presence(name, value, _args)
      raise "#{name} can't be empty" if value.nil? || ((value.is_a? String) && value.empty?)
    end

    def format(name, value, args)
      format = args[0]
      raise "#{name} must be format /#{format.source}/" unless value =~ format
    end

    def type(name, value, args)
      type = args[0]
      raise "#{name} must be type #{type}" unless value.is_a? type
    end
  end
end
