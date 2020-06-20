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
    initialize_rows
    initialize_cols
    initialize_boxes
  end

  def display(display_possible = true)
    print '   '
    9.times { |i| print " #{(65 + i).chr}  " }
    print "\n  +"
    puts '---+' * 9
    @board.each_slice(9).with_index do |row, y|
      display_row_top(row, display_possible)
      display_row_middle(row, y, display_possible)
      display_row_bottom(row, display_possible)
      print '  +'
      if y % 3 == 2
        puts '===+' * 9
      else
        puts '---+' * 9
      end
    end
  end

  def solve?
    return @board.all?(&:solve?)
  end

  def auto_solve
    methods = %i[simple_elimination single]
    i = 0
    while i < methods.length
      changes = send methods[i]
      if changes.zero?
        i += 1
      else
        i = 0
      end
    end
  end

  def simple_elimination
    changes = 0

    @board.each do |cell|
      next if cell.solve?

      original_possible = cell.possible

      cell.possible -= @rows[cell.y].map(&:value)
      cell.possible -= @cols[cell.x].map(&:value)
      cell.possible -= @boxes[box_num(cell.x, cell.y)].map(&:value)

      changes += 1 if cell.possible != original_possible
    end

    return changes
  end

  def single
    changes = 0

    @board.each do |cell|
      next if cell.value != 0
      next if cell.possible.length != 1

      cell.value = cell.possible[0]
      changes += 1
    end

    return changes
  end

  private

  def empty_board
    return Array.new(81) { |i| Cell.new(i % 9, i / 9) }
  end

  def initialize_rows
    @rows = []
    9.times do |y|
      @rows.push(@board[y * 9, 9])
    end
  end

  def initialize_cols
    @cols = []
    9.times do |x|
      @cols.push(@board.select { |other| other.x == x })
    end
  end

  def box_num(x, y)
    return x / 3 + y / 3 * 3
  end

  def initialize_boxes
    @boxes = Array.new(9) { [] }

    @board.each do |cell|
      @boxes[box_num(cell.x, cell.y)].push(cell)
    end
  end

  def display_row_top(row, display_possible)
    print '  |'
    row.each do |cell|
      if !display_possible || cell.solve?
        print '   '
      else
        print cell.display_possible([1, 2, 3]).join
      end
      if cell.x % 3 == 2
        print '$'
      else
        print '|'
      end
      print "\n" if cell.x == 8
    end
  end

  def display_row_middle(row, y, display_possible)
    print "#{y} |"
    row.each do |cell|
      if cell.solve?
        print " #{cell.value} "
      elsif !display_possible
        print '   '
      else
        print cell.display_possible([4, 5, 6]).join
      end
      if cell.x % 3 == 2
        print '$'
      else
        print '|'
      end
      print "\n" if cell.x == 8
    end
  end

  def display_row_bottom(row, display_possible)
    print '  |'
    row.each do |cell|
      if !display_possible || cell.solve?
        print '   '
      else
        print cell.display_possible([7, 8, 9]).join
      end
      if cell.x % 3 == 2
        print '$'
      else
        print '|'
      end
      print "\n" if cell.x == 8
    end
  end
end
