class Route
  attr_reader :path

  def initialize(from_station, to_station)
    @path = [from_station, to_station]
  end

  def add_station(station)
    path.insert(-2, station)
  end

  def remove_station(station)
    path.delete(station) if station != path.first && station != path.last
  end

  def show
    path.each do |station|
      if station == path.first
        print station.name
      else
        print " => #{station.name}"
      end
    end
  end
end
