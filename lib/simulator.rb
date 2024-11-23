# frozen_string_literal: true

require 'matrix'
require_relative 'config'
require_relative 'move'
require_relative 'turn'
require_relative 'validation'

# Simulates a toy robots movement on a square
class Simulator
  # Places the robot on a specified square on the board using x,y coordinates and a direction to face
  def place(x, y, facing)
    unless Validation.legal_move?(x,y)
      puts "Invalid move 'X: #{x} Y: #{y}'"
      return
    end

    unless Validation.supported_direction?(facing)
      puts "Invalid direction '#{facing}'"
      return
    end

    square[current_coordinates.first][current_coordinates.last] = Config::DEFAULT_VALUE if current_coordinates
    square[x][y] = Config::TOY

    @placed = true
    @facing = facing
  end

  # outputs the toy robots current coordinates and where it is facing e.g. "0,0,NORTH"
  def report
    current_coordinates
    return if @facing.nil? || @x.nil? || @y.nil?

    "#{@x},#{@y},#{@facing}"
  end

  # moves the toy robot forward on the square in the direction it is facing
  def move
    return unless @placed

    current_coordinates

    @square = Move.new(square, x, y, facing).call
  end

  def left
    return unless @placed

    @facing = Turn.left(facing)
  end

  def right
    return unless @placed

    @facing = Turn.right(facing)
  end

  private

  attr_reader :facing, :x, :y

  def current_coordinates
    @x, @y = Matrix[*square].index(Config::TOY)
  end

  def square
    @square ||= Array.new(Config::X_SIZE) do
      Array.new(Config::Y_SIZE).fill do
        Config::DEFAULT_VALUE
      end
    end
  end
end
