# frozen_string_literal: true

require_relative 'solver'

def greeting
  puts "Welcome to Sudoku Solver\n"
end

def prepare_solver
  file = open('sample.txt', 'r')
  board = file.read.split
  return Solver.new(board)
end

def start_solver(solver)
  solver.display

  option = ''
  until solver.solve?
    puts 'Please select an option:'
    puts '1. Simple row and column elimination'
    puts '2. Exit'
    print '> '
    option = gets.chomp
    next if option.empty?

    case option
    when '1'
      changes = solver.simple_elimination
      solver.display
      puts "Done! #{changes} cells are modified"
    when '2'
      exit
    else
      puts "Sorry, I don't understand: '#{option}'\n\n"
    end
  end
end

def start_prompt
  option = ''

  while option.empty?
    puts 'Please select an option:'
    puts '1. Solve'
    puts '2. Exit'
    print '> '
    option = gets.chomp
    next if option.empty?

    case option
    when '1'
      solver = prepare_solver
      start_solver(solver)
    when '2'
      puts 'Bye Bye...'
      exit
    else
      puts "Sorry, I don't understand: '#{option}'\n\n"
      option = ''
    end
  end
end

def main
  greeting
  start_prompt
end

main
