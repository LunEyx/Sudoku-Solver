# frozen_string_literal: true

require_relative 'solver'

def greeting
  puts "Welcome to Sudoku Solver\n"
end

def start_solver(solver)
  until solver.solve?
    puts 'Please select an option:'
    puts '0. Auto Solve'
    puts '1. Simple Elimination'
    puts '2. Single'
    puts '9. Exit'
    print '> '
    option = gets.chomp
    next if option.empty?

    changes = solver_action(solver, option)
    next if changes == -1

    solver.display
    puts "Done! #{changes} cells are modified"
  end
end

def solver_action(solver, option)
  case option
  when '0'
    solver.auto_solve
    solver.display
    if solver.solve?
      puts 'Done!'
    else
      puts 'No Solution.'
    end
    exit
  when '1'
    return solver.simple_elimination
  when '2'
    return solver.single
  when '9'
    exit
  else
    puts "Sorry, I don't understand: '#{option}'\n\n"
    return -1
  end
end

def create_solver(board)
  solver = Solver.new(board)
  solver.display(false)
  start_solver(solver)
end

def create_solver_from_file(filename)
  file = File.open(filename, 'r')
  board = file.read.split
  create_solver(board)
end

def create_solver_from_input
  board = gets.chomp.split
  create_solver(board)
end

def start_prompt
  option = ''

  while option.empty?
    puts 'Please select an option:'
    puts '1. Solve from sample.txt'
    puts '2. Solve from input'
    puts '3. Exit'
    print '> '
    option = gets.chomp
    next if option.empty?

    option = '' unless start_action(option)
  end
end

def start_action(option)
  case option
  when '1'
    create_solver_from_file('sample.txt')
  when '2'
    create_solver_from_input
  when '3'
    puts 'Bye Bye...'
    exit
  else
    puts "Sorry, I don't understand: '#{option}'\n\n"
    return false
  end

  return true
end

def main
  greeting
  start_prompt
end

main
