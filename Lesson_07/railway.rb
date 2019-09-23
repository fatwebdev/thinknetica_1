class Railway
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    loop do
      render_options('menu', main_menu_options)
      choice = option_choice

      break if choice.zero?

      case choice
      when 1 then create_station
      when 2 then show_stations
      when 3 then create_route
      when 4 then edit_route
      when 5 then create_train
      when 6 then train_actions
      end
    end
  end

  def seed
    minsk = Station.new('Minsk')
    moscow = Station.new('Moscow')
    berlin = Station.new('Berlin')

    @stations = [minsk, moscow, berlin]

    moscow_to_berlin = Route.new(moscow, berlin)
    minsk_to_berlin = Route.new(minsk, berlin)

    @routes = [moscow_to_berlin, minsk_to_berlin]

    passenger_wagon = PassengerWagon.new(40)
    passenger_wagon.occupy
    passenger_wagon.occupy

    cargo_wagon = CargoWagon.new(100)

    passenger_train = PassengerTrain.new('too-to')
    passenger_train.define_route(moscow_to_berlin)
    passenger_train.add_wagon(passenger_wagon)
    passenger_train.add_wagon(PassengerWagon.new(40))

    cargo_train = CargoTrain.new('12334')
    cargo_train.define_route(minsk_to_berlin)
    cargo_train.add_wagon(cargo_wagon)

    @trains = [passenger_train, cargo_train]
  end

  private

  def main_menu_options
    [
      '1 - create new station',
      '2 - show all stations with trains on that',
      '3 - create route',
      '4 - edit route',
      '5 - create new train',
      '6 - train actions',
      '0 - exit'
    ]
  end

  def create_station
    print_title('create station')
    print 'Enter station name... '
    name = gets.chomp

    station = Station.new(name)
    @stations << station
  rescue RuntimeError => e
    print_error(e.message)
    retry
  end

  def train_types_menu_options
    [
      '1 - passenger train',
      '2 - cargo train'
    ]
  end

  def create_train
    render_options('create train', train_types_menu_options)
    choice = option_choice
    choiced_train = case choice
                    when 1 then PassengerTrain
                    when 2 then CargoTrain
                    end

    begin
      print 'Enter train number... '
      number = gets.chomp
      train = choiced_train.new(number)
      @trains << train
    rescue RuntimeError => e
      print_error(e.message)
      retry
    end
  end

  def choiced_entity(title, entity_collection, name_attribute)
    menu_options = entity_collection.map.with_index do |entity, idx|
      "#{idx + 1} - #{entity.public_send name_attribute}"
    end
    render_options(title, menu_options)
    entity_collection[option_choice - 1]
  end

  def choiced_train
    choiced_entity('choice train', @trains, :number)
  end

  def choiced_route
    choiced_entity('choice route', @routes, :to_s)
  end

  def choiced_station(title = 'station')
    choiced_entity("choice #{title}", @stations, :name)
  end

  def choiced_wagon(wagons)
    choiced_entity("choice wagon", wagons, :number)
  end

  def create_route
    start_station = choiced_station('start station')
    end_station = choiced_station('end station')
    route = Route.new(start_station, end_station)
    @routes << route
  rescue RuntimeError => e
    print_error(e.message)
    retry
  end

  def edit_route_menu_options
    [
      '1 - add station',
      '2 - remove station'
    ]
  end

  def edit_route
    route = choiced_route
    render_options('route actions', edit_route_menu_options)
    case option_choice
    when 1 then route.add_station(choiced_station)
    when 2 then route.remove_station(choiced_station)
    end
  end

  def train_actions_menu_options
    [
      '1 - set route',
      '2 - train wagons actions',
      '3 - move forward',
      '4 - move backward'
    ]
  end

  def train_actions
    if @trains.empty?
      print_error('Not a single train was created')
      return
    end

    train = choiced_train
    render_options('train actions', train_actions_menu_options)

    case option_choice
    when 1 then train.define_route(choiced_route)
    when 2 then train_wagons_actions(train)
    when 3 then train.forward
    when 4 then train.backward
    end
  end

  def train_wagons_actions_menu_options
    [
      '1 - add wagon',
      '2 - remove wagon',
      '3 - occupy in wagon',
      '4 - show wagons'
    ]
  end

  def train_wagons_actions(train)
    render_options('train wagons actions', train_wagons_actions_menu_options)

    case option_choice
    when 1 then train_add_wagon(train)
    when 2 then train.remove_wagon
    when 3 then wagon_occupy(train)
    when 4 then show_wagons(train, title: true)
    end
  end

  def wagon_occupy(train)
    wagon = choiced_wagon(train.wagons)

    case wagon
    when PassengerWagon
      wagon.occupy
    when CargoWagon
      print 'Enter occupy capacity... '
      capacity = gets.chomp.to_i
      wagon.occupy(capacity)
    end
  end

  def train_add_wagon(train)
    wagon = case train.type
            when 'passenger' then PassengerWagon
            when 'cargo' then CargoTrain
            end

    print 'Enter wagon capacity... '
    capacity = gets.chomp.to_i
    train.add_wagon(wagon.new(capacity))
  end

  def show_wagons(train, options = {})
    padding = "\t" * options[:offset] ||= 0
    print_title('train wagons') if options[:title]

    if train.wagons.length.zero?
      puts "#{padding}There are no wagons in the train."
      return
    end

    train.each_wagon do |wagon|
      puts "#{padding}#: %-8s  type: %10s  occupied: %d out of %d" % [wagon.number, wagon.type, wagon.occupied, wagon.full_capacity]
    end
  end

  def show_trains(station)
    if station.trains.empty?
      puts "\tThere are no trains at the station."
      return
    end

    station.each_train do |train|
      puts "\t#: %-8s type: %-10s wagons count: %d" % [train.number, train.type, train.wagons.length]
      show_wagons(train, offset: 2)
    end
  end

  def show_stations
    print_title('show stations')
    @stations.each do |station|
      puts station.name
      show_trains(station)
    end
  end

  def print_title(title)
    puts ''
    border = '=' * ((30 - title.length) / 2)
    puts border + title.upcase + border
  end

  def print_error(msg)
    print_title('error')
    puts msg
  end

  def render_options(title, menu)
    print_title(title)
    menu.each { |option| puts option }
  end

  def option_choice
    print 'Select option... '
    gets.chomp.to_i
  end
end
