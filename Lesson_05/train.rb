class Train
  attr_accessor :speed
  attr_reader :wagon_count, :current_station, :number, :type

  include Manufacturer
  include InstanceCounter

  @trains = []

  class << self
    def find(number)
      @trains.select { |train| train.number == number }.first
    end

    attr_accessor :trains
  end

  def initialize(number)
    @number = number
    @type = type
    @wagons = []

    @speed = 0

    self.class.trains << self
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if speed.zero?
  end

  def remove_wagon
    @wagons.pop if speed.zero? && !@wagons.empty?
  end

  def define_route(route)
    return if route.nil?

    @route = route
    station = route.path.first
    station.take_train(self)
    @current_station = station
  end

  def forward
    arrive_at_station(next_station)
  end

  def backward
    arrive_at_station(prev_station)
  end

  def prev_station
    idx_current_station = @route.path.index(@current_station)
    @route.path[idx_current_station - 1] if idx_current_station > 0
  end

  def next_station
    idx_current_station = @route.path.index(@current_station)
    @route.path[idx_current_station + 1] if idx_current_station < @route.path.length - 1
  end

  private

  # for public, train can move only on next station or prev station
  def arrive_at_station(station)
    return if station.nil?

    current_station.delete_train(self)
    station.take_train(self)
    @current_station = station
  end
end
