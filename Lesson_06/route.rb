class Route
  attr_reader :path

  include InstanceCounter

  def initialize(from_station, to_station)
    @path = [from_station, to_station]

    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
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

  private

  def validate!
    raise 'Route must have start station and end station' unless path.all? { |i| i.is_a?(Station) }
  end
end
