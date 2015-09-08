require 'ship'

describe Ship do

  describe '#size' do
    it { expect(subject).to respond_to(:size).with(0).argument }
  end

  describe '#body' do
    it { expect(subject).to respond_to(:body).with(0).argument }

    it 'should have the correct number of parts' do
      ship = Ship.new(3)
      expect(ship.body.count).to eql(ship.size)
    end

    it 'should have default body part attributes' do
      ship = Ship.new(3)
      (0...ship.size).each do |i|
      expect(ship.body[i][:grid_coords]).to eql([])
      end
    end

    it 'should have default body part attributes, with hit false' do
      ship = Ship.new(3)
      (0...ship.size).each do |i|
      expect(ship.body[i][:hit]).to eql(false)
      end
    end
  end
end
