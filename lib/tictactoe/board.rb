module TicTacToe
  class Board
    EMPTY_POSITIONS = Array.new(9, nil)

    attr_reader :positions

    def initialize(positions = EMPTY_POSITIONS)
      @positions = positions
    end

    def empty?
      @positions.all?(&:nil?)
    end

    def full?
      @positions.none?(&:nil?)
    end

    def taken?(position)
      !@positions[position].nil?
    end

    def valid?(position)
      position >= 0 && position < @positions.length
    end

    def take_position(player, position)
      self.class.new(@positions.dup.tap { |p| p[position] = player })
    end

    def moves_of(player)
      @positions.each_index.select { |i| @positions[i] == player }
    end

    def ==(other)
      @positions == other.positions
    end
  end
end
