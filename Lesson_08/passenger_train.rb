class PassengerTrain < Train
  def type
    'passenger'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.class == PassengerWagon
  end
end
