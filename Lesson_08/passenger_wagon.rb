# frozen_string_literal: true

class PassengerWagon < Wagon
  def type
    'passenger'
  end

  def occupy
    super(1)
  end
end
