require_relative 'simulator'

class OperationExecutor
  OPERATIONS = {
    'PLACE' => :place,
    'MOVE' => :move,
    'LEFT' => :left,
    'RIGHT' => :right,
    'REPORT' => :report,
  }.freeze

  def call(input)
    @input = input

    operation = OPERATIONS.fetch(input.first) { return false }

    send(operation) if operation
  end

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

  def move
    execute_operation do
      simulator.move
    end
  end

  def left
    execute_operation do
      simulator.left
    end
  end

  def right
    execute_operation do
      simulator.right
    end
  end

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