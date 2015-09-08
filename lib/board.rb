require_relative 'ship'

class Board

  # attr_accessor :ships
  attr_reader :size, :ships, :hits, :misses

  def initialize(size=10)
    @size = size
    @ships = []
    @ship_coords = nil
    @hits = []
    @misses = []
    @ocean =[]
    (0...size).each do |x|
      (0...size).each do |y|
        @ocean << [x,y]
      end
    end
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

  def ship_coords
    @ship_coords = []
    @ships.each do |ship|
      ship.body.each do |hash|
        @ship_coords  << hash[:grid_coords]
      end
    end
    @ship_coords
  end

  def overlap?(ship, x_coord, y_coord, orientation)
    new_coords_to_add = new_ship_coords(ship.size, x_coord, y_coord, orientation)
    result  = new_coords_to_add & ship_coords
    if result == []
      return false
    else
      return true
    end
  end

  def place_ship(ship, x_coord, y_coord, orientation)
    fail 'outside range' if outside?(ship, x_coord, y_coord, orientation)
    fail 'overlap?' if overlap?(ship, x_coord, y_coord, orientation)
    new_choords = new_ship_coords(ship.size, x_coord, y_coord, orientation)
    (0...ship.size).each do |i|
      ship.body[i][:grid_coords] = new_choords[i]
    end
    @ships << ship
    return nil
  end

  def fire_missle(x_coord, y_coord)
    fail 'outside range' if x_coord >= size || y_coord >= size || x_coord < 0 || y_coord < 0
    fail 'already fired at this location' if hits.include?([x_coord, y_coord]) || misses.include?([x_coord, y_coord])
      ships.each do |ship|
        ship.body.each do |part|
          if part[:grid_coords] == [x_coord, y_coord]
            part[:hit] = true
            @hits << [x_coord, y_coord]
            return 'hit'
          end
        end
      end
      @misses << [x_coord, y_coord]
      return 'miss'
  end

  def ocean
    @ocean =[]
    (0...size).each do |x|
      (0...size).each do |y|
        @ocean << [x,y]
      end
    end
    @ocean = @ocean - ship_coords - @misses
    return @ocean
  end

  def show_my_board 
    ship_not_hit = ship_coords - @hits 
    #hits, misses, ocean
    (0...size).each do |x|
      print '[ '
      (0...size).each do |y|
        current_coord = [x, y]
        if @hits.include?(current_coord)
          print 'Ship-hit      '
        elsif @misses.include?(current_coord)
          print 'Ocean-miss    '
        elsif ship_not_hit.include?(current_coord)
          print 'Ship-not-hit  '
        elsif @ocean.include?(current_coord)
          print 'Ocean         '
        end
      end
      print ']'
      puts ''
    end
  end

end

board = Board.new(4)
ship1 = Ship.new(3)
ship2 = Ship.new(2)

board.place_ship(ship1,0,1,'south')
board.place_ship(ship2,2,2,'east')

p board.fire_missle(1,1)
p board.fire_missle(2,1)
p board.fire_missle(3,1)
p board.fire_missle(3,2)
p board.fire_missle(1,2)

p board.hits
p board.misses
p board.ship_coords - board.hits
p board.ocean
board.show_my_board
