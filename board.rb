require 'matrix'
load 'cell.rb'
require 'pry'

class Board
  def initialize
  end

  def build
    @size = 10
    @board = Matrix.build(@size){rand (0..1)}
  end

  def read
    puts "= "*50
    print @board.each_slice(@board.column_size){|r| p r}
    puts "= "*50

    (0..9).each do |row|
      (0..9).each do |column|
        cell = @board[row, column]
        status = Cell.new.alive?(cell)
        alive_neighbours = neighbours(row,column)

        if status && alive_neighbours >=4
          @board[row, column] = 0
        elsif status && alive_neighbours >=2
          @board[row, column] = 1
        elsif status && alive_neighbours <=1
          @board[row, column] = 0
        elsif status == false && alive_neighbours == 3
          @board[row, column] = 1
        end
      end
    end

    puts "= "*50
    print @board.each_slice(@board.column_size){|r| p r}
    puts "= "*50
  end

  def neighbours(row, column)
    neighbours = []
    neighbours.push(@board[row-1, column]) if inside_board?(row-1, column)
    neighbours.push(@board[row-1, column+1]) if inside_board?(row-1, column+1)
    neighbours.push(@board[row, column+1]) if inside_board?(row, column+1)
    neighbours.push(@board[row+1, column+1]) if inside_board?(row+1, column+1)
    neighbours.push(@board[row+1, column]) if inside_board?(row+1, column)
    neighbours.push(@board[row+1, column-1]) if inside_board?(row+1, column-1)
    neighbours.push(@board[row, column-1]) if inside_board?(row, column-1)
    neighbours.push(@board[row-1, column-1]) if inside_board?(row-1, column-1)
    neighbours.count(1)
  end

  def inside_board?(row, column)
    row < @size && row >= 0 && column < @size && column >= 0
  end
 
  def print_board
    # Esto nos ayuda para hacer la matrix en cuadrito
    @board.to_a.each {|r| puts r.inspect}
  end
end

class Matrix
  public :"[]=", :set_element, :set_component
end

i = 0
loop do
  i += 1
  puts i
  board = Board.new
  board.build
  board.read
  break if i == 5 # this will cause execution to exit the loop
end
# puts "= "*50
# board.print_board
