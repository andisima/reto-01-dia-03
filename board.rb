require 'matrix'
load 'cell.rb'

class Board
  def initialize
  end

  def build
    @size = 10
    @board = Matrix.build(@size){rand (0..1)}
  end

  def read
    (0..9).each do |row|
      (0..9).each do |column|
        cell = @board[row, column]
        status = Cell.new.alive?(cell)
      end
    end
  end

  def neighbours(row, column)
    neighbours = []
    neighbours.push(@board[row-1, column]) if inside_board?(row-1, column)
    neighbours.push(@board[row-1, column+1]) if inside_board?(row-1, column+1)
    neighbours.push(@board[row-1, column+1]) if inside_board?(row-1, column+1)
    puts neighbours
  end

  def inside_board?(row, column)
    row < @size && row >= 0 && column < @size && column >= 0
  end

  def print_board
    print @board
  end
end


board = Board.new

board.build
board.read
board.print_board
board.neighbours(1, 0)
