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
      @positions.each_index.include?(position)
    end

    def mark_position(value, position)
      self.class.new(@positions.dup.tap { |p| p[position] = value })
    end

    def positions_with_value(value)
      @positions.each_index.select { |i| @positions[i] == value }
    end

    def ==(other)
      @positions == other.positions
    end
  end
end
