class Station
  attr_reader :trains, :name

  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name

    @trains = {}

    validate!

    @@stations << self
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def take_train(train)
    if trains[train.type]
      trains[train.type] << train
    else
      trains[train.type] = [train]
    end
  end

  def send_train(train)
    train.forward
  end

  def delete_train(train)
    trains[train.type].delete(train)
  end

  private

  def validate!
    raise 'Station name can\'t be empty' if name.empty?
    raise 'Station name length must be less or equal 15 symbols' if name.length > 15
    raise 'Station with that name already created' if @@stations.any? { |station| station != self && station.name == name }
  end
end
