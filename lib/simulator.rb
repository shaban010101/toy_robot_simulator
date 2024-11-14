class Simulator
  VALID_DIRECTIONS = [
    'NORTH',
    'SOUTH',
    'EAST',
    'WEST'
  ]
  X_AXIS_SIZE = 5
  Y_AXIS_SIZE = 5
  TOY = 'X'
  DEFAULT_VALUE = "O"

  def place(x, y, facing)
    x, y = nil unless (0...X_AXIS_SIZE).to_a.include?(x) && (0...Y_AXIS_SIZE).to_a.include?(x)
    facing = nil unless VALID_DIRECTIONS.include?(facing)

    @x = x
    @y = y
    @facing = facing
  end

  def report
    return "Please enter the correct input values for X, Y and Facing" if (@facing == nil || @x == nil && @y == nil)
    "#{@x},#{@y},#{@facing}"
  end

  def move
    # facing
    # NORTH = UP one row + 1
    # SOUTH = DOWN one row - 1 row
    # WEST = TO the left -1 column
    # EAST = To the right +1 column
    move_row_value = {
      'NORTH' => :+,
      'SOUTH' => :-
    }

    face_index_operation = {
      'NORTH' => :+,
      'SOUTH' => :-,
      'WEST' => :-,
      'EAST' => :+
    }

    if move_row_value.include?(@facing)
      square[@x][@y] = DEFAULT_VALUE
      square[@x][@y.public_send(face_index_operation[@facing], 1)] = TOY
    else
      square[@x][@y] = DEFAULT_VALUE
      square[@x.public_send(face_index_operation[@facing], 1)][@y] = TOY
    end
  end

  private

  def square
    @square ||= Array.new(Y_AXIS_SIZE) { Array.new(X_AXIS_SIZE).fill { DEFAULT_VALUE } }
  end
end