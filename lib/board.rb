require_relative 'ship'

class Board

  attr_reader :size, :ships

  def initialize(size=10)
    @size = size
    @ships = []
  end

  def new_ship_coords(num,x_coord,y_coord,orientation)
    results = []
    case orientation
      when 'south'
        num.times do
        results << [x_coord,y_coord]
        x_coord += 1
        end
      when 'north'
        num.times do
        results << [x_coord,y_coord]
        x_coord -= 1
        end
      when 'east'
        num.times do
        results << [x_coord,y_coord]
        y_coord += 1
        end
      when 'west'
        num.times do
        results << [x_coord,y_coord]
        y_coord -= 1
        end
    end
    results
  end

  def outside?(ship, x_coord, y_coord, orientation)
    coords = new_ship_coords(ship.size, x_coord, y_coord, orientation)
    coords.each do |xy_pair|
      return true if xy_pair.max >= size || xy_pair.min < 0
    end
    return false
  end

  def place_ship(ship, x_coord, y_coord, orientation)

    @ships << ship
    return nil
  end

end

board = Board.new
# p board
p board.new_ship_coords(3,4,2,'south')
