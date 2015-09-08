require 'board'

describe Board do
  describe '#initialize/new' do
    it 'when created has a default size of 10' do
      expect(subject.size).to eql(10)
    end
    it 'when created has a default empty ships array' do
      expect(subject.ships).to eql([])
    end
  end

  describe '#new_ship_coords' do
    it 'returns the correct coords when orientation is south' do
      board = Board.new
      expect(board.new_ship_coords(2,4,5,'south')).to eql([[4, 5], [5, 5]])
    end
    
    it 'returns the correct coords when orientation is north' do
      board = Board.new
      expect(board.new_ship_coords(2,3,6,'north')).to eql([[3, 6], [2, 6]])
    end
    
    it 'returns the correct coords when orientation is east' do
      board = Board.new
      expect(board.new_ship_coords(2,4,5,'east')).to eql([[4, 5], [4, 6]])
    end
    
    it 'returns the correct coords when orientation is west' do
      board = Board.new
      expect(board.new_ship_coords(2,2,3,'west')).to eql([[2, 3], [2, 2]])
    end
  end


  describe '#place_ship' do
    it 'appends a ship to the ships array on the board' do
      ship1 = double(:ship)
      board1 = Board.new
      board1.place_ship(ship1,2,3,'south')
      expect(board1.ships.first).to eql(ship1)
    end

    # it "updates the ship coordinates" do
    #   ship1 = double(:ship)
    #   board1 = Board.new
    #   board1.place_ship(ship1,2,3,'south')
    #   expect(ship1.body[1][:grid_coords]).to eql([3,3])
    # end

  end
end
