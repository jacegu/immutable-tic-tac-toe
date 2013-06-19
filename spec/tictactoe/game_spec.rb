module TicTacToe
  class Game
    def initialize(players, moves = [])
      @players = players
      @moves = moves
    end

    def has_an_empty_board?
      @moves.empty?
    end

    def next_turn_player
      @players.first
    end

    def make_move(position)
      Game.new(@players.reverse, @moves << position)
    end
  end
end

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

    context 'when the move is invalid' do
      it 'does something about it'
    end
  end
end
