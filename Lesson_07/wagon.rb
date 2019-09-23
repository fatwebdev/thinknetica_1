class Wagon
  include Manufacturer

  attr_reader :full_capacity, :number
  attr_reader :occupied

  def initialize(full_capacity)
    @full_capacity = full_capacity
    @occupied = 0
    @number = rand(36**8).to_s(36).upcase
  end

  def type
    'base'
  end

  def occupy(capacity)
    self.occupied += capacity if free_capacity >= capacity
  end

  def free_capacity
    full_capacity - occupied
  end

  protected

  attr_writer :occupied
end
