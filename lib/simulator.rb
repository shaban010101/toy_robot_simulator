require 'matrix'

class Simulator
  PLUS = :+
  MINUS = :-
  VALID_DIRECTIONS = [
    'NORTH',
    'SOUTH',
    'EAST',
    'WEST'
  ]
  # NORTH = UP one row + 1
  # SOUTH = DOWN one row - 1 row
  # WEST = TO the left -1 column
  # EAST = To the right +1 column
  FACE_INDEX_OPERATION = {
    'NORTH' => PLUS,
    'SOUTH' => MINUS,
    'WEST' => PLUS,
    'EAST' => MINUS
  }
  COLUMN_SIZE = 5
  ROW_SIZE = 5
  TOY = 'X'
  DEFAULT_VALUE = "O"

  def place(x, y, facing)
    return unless (0...COLUMN_SIZE).to_a.include?(x) && (0...ROW_SIZE).to_a.include?(x)
    return unless VALID_DIRECTIONS.include?(facing)

    if current_coordinates
      square[current_coordinates.first, current_coordinates.last] = DEFAULT_VALUE
      square[x, y] = TOY
    else
      square[x][y] = TOY
    end

    @facing = facing
  end

  def report
    current_coordinates
    return "Please enter the correct input values for X, Y and Facing" if (@facing == nil || @column == nil && @row == nil)

    "#{@column},#{@row},#{@facing}"
  end

  def move
    # facing
    move_row_value = {
      'NORTH' => PLUS,
      'SOUTH' => MINUS
    }

    current_coordinates

    if move_row_value.include?(facing)
      return unless valid_row
      square[column][row] = DEFAULT_VALUE
      square[column][projected_row] = TOY
    else
      return unless valid_column
      square[column][row] = DEFAULT_VALUE
      square[projected_column][row] = TOY
    end
  end

  private
  attr_reader :column, :row, :facing
  attr_writer :square,:column, :row, :facing


  def current_coordinates
    @column, @row = Matrix[*square].index(TOY)
  end

  def square
    @square ||= Array.new(ROW_SIZE) { Array.new(COLUMN_SIZE).fill { DEFAULT_VALUE } }
  end

  def projected_row = row.public_send(FACE_INDEX_OPERATION[facing], 1)

  def valid_row = (0...ROW_SIZE).to_a.include?(projected_row)

  def projected_column = column.public_send(FACE_INDEX_OPERATION[facing], 1)

  def valid_row = (0...COLUMN_SIZE).to_a.include?(projected_column)
end