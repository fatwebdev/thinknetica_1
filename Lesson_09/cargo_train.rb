# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  def type
    'cargo'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.class == CargoWagon
  end
end
