class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name

    @trains = {}
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

  def show_trains
    puts 'There are trains at the station by type:'
    trains.each do |type, trains_this_type|
      puts "\t#{type}:"
      trains_this_type.each { |train| puts "\t\t#{train.number}" }
    end
  end
end
