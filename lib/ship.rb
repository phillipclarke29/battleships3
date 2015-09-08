require_relative 'board'

class Ship

  attr_reader :size, :body

  def initialize(size=1)
    @size = size
    @body = []
    @size.times {@body << Hash.new}
  end

end

ship = Ship.new(3)

p ship
