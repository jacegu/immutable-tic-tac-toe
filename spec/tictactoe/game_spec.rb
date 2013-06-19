module TicTacToe
  class Game
    def initialize(players, moves = nil)
      @players = players
      @moves = moves || { @players[0] => [], @players[1] => [] }
    end

    def has_an_empty_board?
      @moves[@players[0]].empty? && @moves[@players[1]].empty?
    end

    def next_turn_player
      @players.first
    end

    def make_move(position)
      current_player = @players.first
      @moves[current_player] << position
      Game.new(@players.reverse, @moves)
    end

    def winner
      @moves.find { |(player, moves)| winner_move_in?(moves) }[0]
    end

    private

    def winner_move_in?(moves)
      winner_moves = [[0,1,2], [3,4,5], [0,3,6]]
      (moves.combination(3).to_a & winner_moves).any?
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

    context 'when the game is over' do
    end
  end

  context 'knowing who is the winner' do
    context 'when player1 is the winner' do
      it 'returns player1' do
        moves = [0,3,1,4,2]
        game_after_move = game
        moves.each { |position| game_after_move = game_after_move.make_move(position) }
        expect(game.winner).to eq player1
      end
    end

    context 'when player2 is the winner' do
      it 'returns player2' do
        moves = [0,3,6,4,2,5]
        game_after_move = game
        moves.each { |position| game_after_move = game_after_move.make_move(position) }
        expect(game.winner).to eq player2
      end
    end
  end

end
