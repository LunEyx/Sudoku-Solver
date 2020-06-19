# frozen_string_literal: true

require_relative 'cell'

class Solver
  def initialize(board = [])
    if board.length == 81
      puts 'board -> cell'
      @board = board.map.with_index { |e, i| Cell.new(i % 9, i / 9, e.to_i) }
    else
      puts 'create empty board'
      @board = empty_board
    end
  end

  def display
    print '  '
    9.times { |i| print " #{(65 + i).chr}  " }
    print "\n  +"
    puts '---+' * 9
    @board.each_slice(9).with_index do |row, y|
      display_row_top(row)
      display_row_middle(row, y)
      display_row_bottom(row)
      print '  +'
      puts '---+' * 9
    end
  end

  private

  def empty_board
    return Array.new(81) { |i| Cell.new(i % 9, i / 9) }
  end

  def display_row_top(row)
    print '  |'
    row.each do |cell|
      if cell.solve?
        print '   '
      else
        print cell.display_possible([1, 2, 3]).join
      end
      print '|'
      print "\n" if cell.x == 8
    end
  end

  def display_row_middle(row, y)
    print "#{y} |"
    row.each do |cell|
      if cell.solve?
        print " #{cell.value} "
      else
        print cell.display_possible([4, 5, 6]).join
      end
      print '|'
      print "\n" if cell.x == 8
    end
  end

  def display_row_bottom(row)
    print '  |'
    row.each do |cell|
      if cell.solve?
        print '   '
      else
        print cell.display_possible([7, 8, 9]).join
      end
      print '|'
      print "\n" if cell.x == 8
    end
  end
end
