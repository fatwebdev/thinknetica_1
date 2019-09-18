class Train
  attr_accessor :speed
  attr_reader :wagon_count, :current_station, :number, :type

  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count

    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    self.wagon_count += 1 if speed.zero?
  end

  def remove_wagon
    self.wagon_count -= 1 if speed.zero?
  end

  def define_route(route)
    @route = route
    arrive_at_station(route.path.first)
  end

  def arrive_at_station(station)
    if !current_station || station == prev_station || station == next_station
      current_station.delete_train(self) if current_station
      station.take_train(self)
      @current_station = station
    end
  end

  def forward
    arrive_at_station(next_station)
  end

  def backward
    arrive_at_station(prev_station)
  end

  def prev_station
    @route.prev_station(@current_station)
  end

  def next_station
    @route.next_station(@current_station)
  end
end
