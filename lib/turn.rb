require_relative 'config'

class Turn
  # turns the direction of the robot is facing to the left
  def self.left(facing)
    @facing = Config::LEFT_DIRECTION[facing]
  end

  # turns the direction of the robot is facing to the right
  def self.right(facing)
    @facing = Config::RIGHT_DIRECTION[facing]
  end
end