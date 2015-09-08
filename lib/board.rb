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

    def place_ship(ship, x_coord, y_coord, orientation)

    @ships << ship
    return nil
  end

end

board = Board.new
# p board
p board.new_ship_coords(5,2,3,'west')
