require_relative 'ship'

class Board

  attr_reader :size, :ships

  def initialize(size=10)
    @size = size
    @ships = []
  end


  def place_ship(ship, x_coord, y_coord, orientation)
    @ships << ship
    return nil
  end

end

board = Board.new
p board