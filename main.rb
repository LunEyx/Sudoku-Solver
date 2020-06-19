# frozen_string_literal: true

require_relative 'solver'

def greeting
  puts "Welcome to Sudoku Solver\n"
end

def start_solver
  file = open('sample.txt', 'r')
  board = file.read.split
  solver = Solver.new(board)
  solver.display
end

def start_prompt
  option = ''

  while option.empty?
    puts 'Please select an option:'
    puts '1. Solve'
    puts '2. Exit'
    option = gets.chomp
    case option
    when '1'
      start_solver
    when '2'
      puts 'Bye Bye...'
      exit
    else
      puts "Unknown option: '#{option}'\n\n"
      option = ''
    end
  end
end

def main
  greeting
  start_prompt
end

main
