# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  @@stations = []

  attr_reader :trains, :name
  validate :name, :presence

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name

    @trains = []

    validate!

    @@stations << self
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    train.forward
  end

  def delete_train(train)
    trains.delete(train)
  end

  def each_train
    trains.each { |train| yield(train) } unless @trains.empty?
  end
end
