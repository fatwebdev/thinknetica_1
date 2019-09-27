# frozen_string_literal: true

class CargoTrain < Train
  def type
    'cargo'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.class == CargoWagon
  end
end
