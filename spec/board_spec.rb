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

  describe '#place_ship' do
    it 'appends a ship to the ships array on the board' do
      ship1 = double(:ship)
      board1 = Board.new
      board1.place_ship(ship1,2,3,'south')
      expect(board1.ships.first).to eql(ship1)
    end

    it "updates the ship coordinates" do
      ship1 = double(:ship)
      board1 = Board.new
      board1.place_ship(ship1,2,3,'south')
      expect(ship1.body[1][:grid_coords]).to eql([3,3])
    end
  end
end
