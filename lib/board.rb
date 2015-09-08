require_relative 'ship'

class Board

  # attr_accessor :ships
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

  def current_ship_coords
    results = []
    @ships.each do |ship|
      ship.body.each do |hash|
        results  << hash[:grid_coords]
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
ship1 = Ship.new(3)
ship2 = Ship.new(4)

ship1.body[0][:grid_coords] = "Hello"

board.ships << ship1
board.ships << ship2

p board.ships

p board.current_ship_coords


# p board
# p board.new_ship_coords(3,4,2,'south')
# p board.new_ship_coords(3,4,2,'south')
