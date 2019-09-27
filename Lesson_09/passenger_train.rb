# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  def type
    'passenger'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.class == PassengerWagon
  end
end
