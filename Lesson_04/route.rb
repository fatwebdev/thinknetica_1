class Route
  attr_reader :path

  def initialize(from_station, to_station)
    @path = [from_station, to_station]
  end

  def add_station(station)
    path.insert(-2, station) if station
  end

  def remove_station(station)
    path.delete(station) if station != path.first && station != path.last
  end

  def to_s
    path
      .map(&:name)
      .join(' => ')
  end

  def show
    print to_s
  end
end
