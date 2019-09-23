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
      '2 - add wagon',
      '3 - remove wagon',
      '4 - move forward',
      '5 - move backward'
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
    when 2 then train_add_wagon(train)
    when 3 then train.remove_wagon
    when 4 then train.forward
    when 5 then train.backward
    end
  end

  def train_add_wagon(train)
    wagon = case train.type
            when 'passenger' then PassengerWagon
            when 'cargo' then CargoTrain
            end
    train.add_wagon(wagon.new)
  end

  def show_trains(station)
    if station.trains.empty?
      puts 'There are no trains at the station.'
      return
    end

    puts 'There are trains at the station by type:'
    station.trains.each do |type, trains_this_type|
      puts "\t#{type}:"
      trains_this_type.each { |train| puts "\t\t#{train.number}" }
    end
  end

  def show_stations
    print_title('show stations')
    @stations.each do |station|
      print station.name + '. '
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
