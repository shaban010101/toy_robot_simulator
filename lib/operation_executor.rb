require_relative 'simulator'
require_relative 'config'

# OperationExecutor executes commands based on the input it receives
class OperationExecutor
  # Takes input as an array e.g. ["PLACE", "0,0,NORTH"] matches it with a known command
  def call(input)
    @input = input

    operation = Config::OPERATIONS.fetch(input.first) { return false }

    send(operation) if operation
  end

  # places the robot on the simulator
  def place
    if input[1].nil?
      puts "Please provide an input with X,Y,F"
      return true
    end

    input_commands = input[1].split(',')
    x, y, facing = input_commands
    @simulator = Simulator.new
    @simulator.place(x.to_i, y.to_i, facing)
    return true
  end

  # moves the robot on the simulator
  def move
    execute_operation do
      simulator.move
    end
  end

  # turns the direction the robot is facing to the left on the simulator
  def left
    execute_operation do
      simulator.left
    end
  end

  # turns the direction the robot is facing to the right on the simulator
  def right
    execute_operation do
      simulator.right
    end
  end

  # Reports the current coordinates the robot is facing on the simulator
  def report
    execute_operation do
      puts simulator.report
    end
  end

  private
  attr_reader :simulator, :input

  def execute_operation
    if defined?(@simulator)
      yield
      true
    else
      puts 'Please place the robot first'
      true
    end
  end
end