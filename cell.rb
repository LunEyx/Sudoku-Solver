# frozen_string_literal: true

class Cell
  attr_reader :x, :y
  attr_accessor :value, :possible

  def initialize(x, y, value = 0)
    @x = x
    @y = y
    @value = value
    @possible = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display_possible(indices = [])
    return indices.map { |index| @possible.include?(index) ? index : '.' }
  end

  def solve?
    return @value != 0
  end
end
