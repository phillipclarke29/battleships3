require_relative 'board'

class Game

attr_reader :boards

def initialize
  @boards = []
end

def setup_board
board1 = Board.new
@boards << board1
nil
end



end


# game = Game.new
# ship = Ship.new
# board = Board.new
# board.place_ship(ship,2,2,"North")
# p board
