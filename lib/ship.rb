
class Ship

	attr_accessor :body
	attr_reader :size

	def initialize(size=1)
		@size = size
		@body = []
		size.times do
			part_hash = {grid_coords:[],hit:nil}
			@body << part_hash
		end
	end

end




class Board

	attr_reader :ships, :size

	def initialize(size=10)
		@size = size
		@ships = []
		@ship_coords = []
	end

	def ship_coords
		ships.each do |ship|
			ship.body.each do |part|
				@ship_coords << part[:grid_coords]
			end
		end
		@ship_coords
	end

	def newship_coords(ship, x_coord, y_coord, orientation)
		new_ship_coords = []
		ship.size.times do
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
		new_ship_coords = newship_coords(ship, x_coord, y_coord, orientation)
		new_ship_coords & ship_coords == [] ? false : true
	end

	def place_ship(ship, x_coord, y_coord, orientation)
		fail 'Ship already added' if ships.include?(ship)
		fail 'Outside board' if outside?(ship, x_coord, y_coord, orientation)
		fail 'Overlap with existing ships' if overlap?(ship, x_coord, y_coord, orientation)
		(0...ship.size).each do |i|
			case orientation
				when 'north'
					ship.body[i][:grid_coords] << x_coord
					ship.body[i][:grid_coords] << y_coord
					x_coord -= 1
				when 'south'
					ship.body[i][:grid_coords] << x_coord
					ship.body[i][:grid_coords] << y_coord
					x_coord += 1
				when 'east'
					ship.body[i][:grid_coords] << x_coord
					ship.body[i][:grid_coords] << y_coord
					y_coord += 1
				when 'west'
					ship.body[i][:grid_coords] << x_coord
					ship.body[i][:grid_coords] << y_coord
					y_coord -= 1
			end
		end
		@ships << ship
	end

end

ship1 = Ship.new(3)
ship2 = Ship.new(4)
board1 = Board.new
board1.place_ship(ship1, 1, 5, 'east')
board1.place_ship(ship2, 3, 7, 'west')
board1.ship_coords
board1.place_ship(ship1,1,4,'east')



