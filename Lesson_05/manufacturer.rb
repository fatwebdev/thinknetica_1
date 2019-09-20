module Manufacturer
  def manufacturer=(name)
    self.name = name
  end

  def manufacturer
    name
  end

  private

  attr_accessor :name
end
