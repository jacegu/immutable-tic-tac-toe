require 'set'

module TicTacToe

  class Board
    POSITIONS = Set.new(0..8)

    def initialize(players, players_positions = [[], []])
      @moves = { players[0] => players_positions[0], players[1] => players_positions[1] }
    end

    def empty?
      @moves.values.all?(&:empty?)
    end

    def full?
      POSITIONS == Set.new(@moves.values.flatten)
    end

    def take_position(player, position)
      @moves[player] << position
      Board.new(@moves.keys, @moves.values)
    end

    def moves_of(player)
      @moves[player]
    end
  end

  class Game
    NO_WINNER = ->{ nil }
    WINNER_MOVES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize(board = nil, players)
      @board = board || Board.new(players)
      @players = players
    end

    def has_an_empty_board?
      @board.empty?
    end

    def next_turn_player
      @players.first
    end

    def over?
      !winner.nil? || @board.full?
    end

    def make_move(position)
      Game.new(@board.take_position(@players.first, position), @players.reverse)
    end

    def winner
      @players.find(NO_WINNER) { |player| winner_move_in?(moves_of(player)) }
    end

    private

    def winner_move_in?(moves)
      (moves.combination(3).to_a & WINNER_MOVES).any?
    end

    def moves_of(player)
      @board.moves_of(player)
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

    context 'when the game is over' do
      it 'ignores the move' do
        game_over = game_with_moves(0,3,1,4,2)
        game_after_move = game_over.make_move(5)
        expect(game_after_move).to be game_over
      end
    end

    context 'when there is already a winner' do
    end

    context 'when the position does not exist' do
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
    context 'whenthere are positions left and there is no winner' do
      it 'is not over' do
        game_after_move = game.make_move(0)
        expect(game_after_move).not_to be_over
      end
    end

    context 'when there is a winner before the board is full' do
      it 'is over' do
        won_game = game_with_moves(0, 6, 1, 7, 2)
        expect(won_game).to be_over
      end
    end

    context 'when the board is full before a player wins' do
      it 'is over' do
        over_game = game_with_moves(0,1,2,3,4,5,6,7,8)
        expect(over_game).to be_over
      end
    end
  end

  def game_with_moves(*moves)
    moves.inject(game) { |game, position| game.make_move(position) }
  end
end
