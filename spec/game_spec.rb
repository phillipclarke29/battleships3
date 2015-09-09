require 'game'


describe Game do
 it 'should initialize a new game' do
   expect(subject.class).to eql(Game)

 end

 it {expect(subject).to respond_to(:setup_board)}

 describe '#read boards' do

   it {expect(subject).to respond_to(:boards)}

 end

 describe '#setup board' do

   it 'creates a new board' do
    game1 = Game.new
    game1.setup_board
    expect(game1.boards.count).to eq 1
    expect(game1.boards[0].class).to eq(Board)



   end



 end













end
