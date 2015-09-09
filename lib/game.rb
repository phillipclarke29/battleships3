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


#  board1 = Board.new
#  p board1
# ship = Ship.new
# p ship# game1=Game.new
#
# p game1.setup_board
