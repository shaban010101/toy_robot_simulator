require 'matrix'
require_relative 'config'

# Simulates a toy robots movement on a square
class Simulator
  # Places the robot on a specified square on the board using x,y coordinates and a direction to face
  def place(x, y, facing)
    return unless (0...Config::COLUMN_SIZE).to_a.include?(x) && (0...Config::ROW_SIZE).to_a.include?(x)
    return unless Config::VALID_DIRECTIONS.include?(facing)

    if current_coordinates
      square[current_coordinates.first, current_coordinates.last] = DEFAULT_VALUE
      square[x, y] = Config::TOY
    else
      square[x][y] = Config::TOY
    end

    @facing = facing
  end

  # outputs the toy robots current coordinates and where it is facing e.g. "0,0,NORTH"
  def report
    current_coordinates
    return if (@facing == nil || @column == nil && @row == nil)

    "#{@column},#{@row},#{@facing}"
  end

  # moves the toy robot forward on the square in the direction it is facing
  def move
    current_coordinates

    if [Config::NORTH, Config::SOUTH].include?(facing)
      return unless valid_row?
      square[column][row] = Config::DEFAULT_VALUE
      square[column][projected_row] = Config::TOY
    else
      return unless valid_column?
      square[column][row] = Config::DEFAULT_VALUE
      square[projected_column][row] = Config::TOY
    end
  end

  # turns the direction of the robot is facing to the left
  def left
    @facing = Config::LEFT_DIRECTION[facing]
  end

  # turns the direction of the robot is facing to the right
  def right
    @facing = Config::RIGHT_DIRECTION[facing]
  end

  private
  attr_reader :column, :row, :facing
  attr_writer :square,:column, :row, :facing


  def current_coordinates
    @column, @row = Matrix[*square].index(Config::TOY)
  end

  def square
    @square ||= Array.new(Config::ROW_SIZE) { Array.new(Config::COLUMN_SIZE).fill { Config::DEFAULT_VALUE } }
  end

  def projected_row = row.public_send(Config::FACE_INDEX_OPERATION[facing], 1)

  def valid_row? = (0...Config::ROW_SIZE).to_a.include?(projected_row)

  def projected_column = column.public_send(Config::FACE_INDEX_OPERATION[facing], 1)

  def valid_column? = (0...Config::COLUMN_SIZE).to_a.include?(projected_column)
end