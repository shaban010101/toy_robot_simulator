class Simulator
  VALID_DIRECTIONS = [
    'NORTH',
    'SOUTH',
    'EAST',
    'WEST'
  ]
  X_AXIS_SIZE = 5
  Y_AXIS_SIZE = 5

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
end