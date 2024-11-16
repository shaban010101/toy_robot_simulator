# frozen_string_literal: true

require 'matrix'
require_relative 'config'

# Simulates a toy robots movement on a square
class Simulator
  # Places the robot on a specified square on the board using x,y coordinates and a direction to face
  def place(x, y, facing)
    return unless (0...Config::X_SIZE).to_a.include?(x) && (0...Config::Y_SIZE).to_a.include?(y)
    return unless Config::VALID_DIRECTIONS.include?(facing)

    square[current_coordinates.first][current_coordinates.last] = Config::DEFAULT_VALUE if current_coordinates
    square[x][y] = Config::TOY

    @placed = true
    @facing = facing
  end

  # outputs the toy robots current coordinates and where it is facing e.g. "0,0,NORTH"
  def report
    current_coordinates
    return if @facing.nil? || (@x.nil? && @y.nil?)

    "#{@x},#{@y},#{@facing}"
  end

  # moves the toy robot forward on the square in the direction it is facing
  def move
    return unless @placed

    current_coordinates

    if [Config::NORTH, Config::SOUTH].include?(facing)
      return unless valid_y_move?

      square[x][y] = Config::DEFAULT_VALUE
      square[x][projected_y] = Config::TOY
    else
      return unless valid_x_move?

      square[x][y] = Config::DEFAULT_VALUE
      square[projected_x][y] = Config::TOY
    end
  end

  # turns the direction of the robot is facing to the left
  def left
    return unless @placed

    @facing = Config::LEFT_DIRECTION[facing]
  end

  # turns the direction of the robot is facing to the right
  def right
    return unless @placed

    @facing = Config::RIGHT_DIRECTION[facing]
  end

  private

  attr_reader :facing, :x, :y

  def current_coordinates
    @x, @y = Matrix[*square].index(Config::TOY)
  end

  def square
    @square ||= Array.new(Config::X_SIZE) { Array.new(Config::Y_SIZE).fill { Config::DEFAULT_VALUE } }
  end

  def projected_x = x.public_send(Config::FACE_INDEX_OPERATION[facing], 1)

  def valid_x_move? = (0...Config::X_SIZE).to_a.include?(projected_x)

  def projected_y = y.public_send(Config::FACE_INDEX_OPERATION[facing], 1)

  def valid_y_move? = (0...Config::Y_SIZE).to_a.include?(projected_y)
end
