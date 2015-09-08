require_relative 'board'

class Ship

  attr_reader :size, :body

  def initialize(size=1)
    @size = size
    @body = []
    @size.times do
      @body << {grid_coords:[], hit:false}
    end
  end

end

ship1 = Ship.new(3)
p ship1