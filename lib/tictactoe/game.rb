require_relative 'board'

module TicTacToe
  class Game
    NO_WINNER = ->{ nil }
    WINNER_MOVES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    attr_reader :board

    def initialize(board = nil, players)
      @board = board || Board.new
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
      return self if over? || @board.taken?(position)
      Game.new(@board.take_position(@players.first, position), @players.reverse)
    end

    def winner
      @players.find(NO_WINNER) { |player| winner_move_in?(moves_of(player)) }
    end

    def ==(other)
      return @board == other.board
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
