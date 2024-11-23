class Robot
  def initialize(square)
    @square = square
  end

  # moves the toy robot forward on the square in the direction it is facing
  def move
    return unless @placed

    current_coordinates

    if [Config::NORTH, Config::SOUTH].include?(facing)
      unless valid_y_move?
        puts "Robot cannot be moved as the move is invalid"
        return
      end

      square[x][y] = Config::DEFAULT_VALUE
      square[x][projected_y] = Config::TOY
    else
      unless valid_x_move?
        puts "Robot cannot be moved as the move is invalid"
        return
      end

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

end