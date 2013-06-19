require 'game'

A_PLAYER = 'a player'
OTHER_PLAYER = 'other player'

describe TicTacToe::Game do
  let(:game)     { described_class.new([player1, player2]) }
  let(:player1)  { A_PLAYER }
  let(:player2)  { OTHER_PLAYER }

  it 'starts with an empty board' do
    expect(game).to have_an_empty_board
  end

  it 'gives the turn to player 1' do
    expect(game.next_turn_player).to be player1
  end

  describe 'making a move' do
    context 'when the move is valid' do
      it 'passes the turn to the next player' do
        game_after_move = game.make_move(0)
        expect(game_after_move.next_turn_player).to be player2
      end

      it 'knows marks the board position as taken' do
        game_after_move = game.make_move(0)
        expect(game_after_move).not_to have_an_empty_board
      end
    end

    context 'when the game is over' do
      it 'ignores the move' do
        game_after_move = over_game.make_move(5)
        expect(game_after_move).to eq over_game
      end
    end

    context 'when there is already a winner' do
      it 'ignores the move' do
        game_after_move = won_game.make_move(5)
        expect(game_after_move).to eq won_game
      end
    end

    context 'when the position does not exist' do
      it 'ignores the move' do
        game_after_move = game.make_move(9)
        expect(game_after_move).to eq game
      end
    end

    context 'when the position is taken' do
      it 'ignores the move' do
        game_after_move = game.make_move(0)
        expect(game_after_move).to eq game_after_move.make_move(0)
      end
    end
  end

  context 'knowing who is the winner' do
    context 'when player1 is the winner' do
      it 'returns player1' do
        expect(game_with_moves(0,3,1,4,2).winner).to eq player1
      end
    end

    context 'when player2 is the winner' do
      it 'returns player2' do
        expect(game_with_moves(0, 3, 6, 4, 2, 5).winner).to eq player2
      end
    end

    context 'when three is no winner' do
      it 'returns nil (for now)' do
        expect(game.winner).to be_nil
      end
    end
  end

  describe 'knowing whether the game is over' do
    context 'when there are positions left and there is no winner' do
      it 'is not over' do
        game_after_move = game.make_move(0)
        expect(game_after_move).not_to be_over
      end
    end

    context 'when there is a winner before the board is full' do
      it 'is over' do
        expect(won_game).to be_over
      end
    end

    context 'when the board is full before a player wins' do
      it 'is over' do
        expect(over_game).to be_over
      end
    end
  end

  def won_game
    game_with_moves(0, 6, 1, 7, 2)
  end

  def over_game
    game_with_moves(0,1,2,3,4,5,6,7,8)
  end

  def game_with_moves(*moves)
    moves.inject(game) { |game, position| game.make_move(position) }
  end
end
