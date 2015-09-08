
class Ship

	attr_accessor :body
	attr_reader :size

	def initialize(size=1)
		@size = size
		@body = []
		size.times do
			part_hash = {grid_coords:[],hit:false}
			@body << part_hash
		end
	end

end

class Board

	attr_reader :ships, :size, :ocean_shots, :ship_hits

	def initialize(size=10)
		@size = size
		@ships = []
		@ship_coords = []
		@ocean_shots = []
		@ship_hits = []
		@empty_coords = []
		(0...size).each do |x|
			(0...size).each do |y|
				coords_array = []
				coords_array << x
				coords_array << y
				@empty_coords << coords_array
			end
		end
	end

	def ship_coords
		@ship_coords = []
		ships.each do |ship|
			ship.body.each do |part|
				@ship_coords << part[:grid_coords]
			end
		end
		@ship_coords
	end

	def empty_coords
		@empty_coords = @empty_coords - ship_coords - ocean_shots
		@empty_coords
	end

def newship_coords(n, x_coord, y_coord, orientation)
	new_ship_coords = []
	n.times do
		case orientation
			when 'north'
				coords = []
				coords << x_coord
				coords << y_coord
				x_coord -= 1
			when 'south'
				coords = []
				coords << x_coord
				coords << y_coord
				x_coord += 1
			when 'east'
				coords = []
				coords << x_coord
				coords << y_coord
				y_coord += 1
			when 'west'
				coords = []
				coords << x_coord
				coords << y_coord
				y_coord -= 1
		end
		new_ship_coords << coords
	end
	new_ship_coords
end

	def outside?(ship, x_coord, y_coord, orientation)
		outside = false
		max_dist = ship.size - 1
		case orientation
			when 'north' then outside = true if x_coord - max_dist < 0
			when 'south' then outside = true if x_coord + max_dist >= size
			when 'east' then outside = true if y_coord + max_dist >= size
			when 'west' then outside = true if y_coord - max_dist < 0
		end
		outside
	end

	def overlap?(ship, x_coord, y_coord, orientation)
		new_ship_coords = newship_coords(ship.size, x_coord, y_coord, orientation)
		if new_ship_coords & ship_coords == [] 
			return false 
		else
			return true
		end
	end

	def place_ship(ship, x_coord, y_coord, orientation)
		fail 'Ship already added' if ships.include?(ship)
		fail 'Outside board' if outside?(ship, x_coord, y_coord, orientation)
		fail 'Overlap with existing ships' if overlap?(ship, x_coord, y_coord, orientation)
		new_ship_coords = newship_coords(ship.size, x_coord, y_coord, orientation)
		(0...ship.size).each do |i|
			ship.body[i][:grid_coords] = new_ship_coords[i]
		end
		@ships << ship
		return nil
	end

	def fire_missle(x_coord, y_coord)
		missle_coords = []
		missle_coords << x_coord
		missle_coords << y_coord
		fail 'already fired at this location' if (ocean_shots + ship_hits).include?(missle_coords)
		fail 'outside of board range' if x_coord >= size || y_coord >= size || x_coord < 0 || y_coord < 0
		ships.each do |ship|
			ship.body.each do |part|
				if part[:grid_coords] == missle_coords
					part[:hit] = true
					ship_hits << missle_coords
					return 'hit'
				end
			end
		end
		ocean_shots << missle_coords
		return 'miss'
	end

end

# ship1 = Ship.new(3)
# ship2 = Ship.new(4)
# board1 = Board.new
# board1.place_ship(ship1, 1, 5, 'east')
# board1.place_ship(ship2, 3, 7, 'west')
# p board1.fire_missle(1,5)
# p board1.fire_missle(2,5)
# p board1.initial_board
def test1
	ship1 = Ship.new(2)
	ship2 = Ship.new(2)
	board1 = Board.new(3)
	board1.place_ship(ship1, 0, 1, 'east')
	board1.place_ship(ship2, 2, 2, 'west')
	p board1.fire_missle(1,1)
	p board1.fire_missle(0,2)
	p board1.fire_missle(2,2)
	p board1.fire_missle(1,2)
	p board1.fire_missle(0,0)
	p board1.ship_coords
	p board1.ship_hits
	p board1.ocean_shots
	p board1.empty_coords
end

def test2
	ship1 = Ship.new(2)
	ship2 = Ship.new(3)
	ship3 = Ship.new(4)
	board1 = Board.new(5)
	board1.place_ship(ship1, 0, 1, 'east')
	board1.place_ship(ship2, 2, 2, 'west')
	board1.place_ship(ship3, 4, 4, 'west')
	p board1.fire_missle(0,1)
	p board1.fire_missle(0,2)
	p board1.fire_missle(0,3)
	p board1.fire_missle(1,2)
	p board1.fire_missle(2,4)
	p board1.fire_missle(2,3)
	p board1.fire_missle(2,2)
	p board1.fire_missle(1,0)
	p board1.ship_coords
	p board1.ship_hits
	p board1.ocean_shots
	p board1.empty_coords
end

test2

