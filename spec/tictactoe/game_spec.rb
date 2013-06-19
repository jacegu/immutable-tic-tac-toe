module TicTacToe
  class Game
    def has_an_empty_board?
      true
    end
  end
end

describe TicTacToe::Game do
  it 'starts with an empty board' do
    game = described_class.new
    expect(game).to have_an_empty_board
  end

  describe 'making a move' do
    context 'when the move is valid' do
      it 'knows who has the next turn'
      it 'knows marks the board position as taken'
    end

    context 'when the move is invalid' do
      it 'does something about it'
    end
  end
end
