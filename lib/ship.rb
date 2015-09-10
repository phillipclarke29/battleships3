# require_relative 'board'

class Ship

  attr_reader :size, :body

  def initialize(size=2)
    @size = size
    @body = []
    @size.times do
      @body << {grid_coords:[], hit:false}
    end
    @sunk = false
  end

  def sunk
    body.each do |part|
      if part[:hit] == false
        @sunk = false
        return @sunk
      end
    end
    @sunk = true # so we never get to this line until all the :hit key's values are true
    return @sunk #now we return sunk
  end
end
