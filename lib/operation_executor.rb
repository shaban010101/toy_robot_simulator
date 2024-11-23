# frozen_string_literal: true

require_relative 'simulator'
require_relative 'config'
require_relative 'console_interface'

# OperationExecutor executes commands based on the input it receives
class OperationExecutor
  # Takes input as an array e.g. ["PLACE", "0,0,NORTH"] matches it with a known command

  def initialize(console_interface: ConsoleInterface.new)
    @console_interface = console_interface
  end

  def call(input)
    @input = input

    Config::OPERATIONS.fetch(input.first) { return false }

    case input.first
    when /^PLACE/
      place
    when /MOVE/
      move
    when /LEFT/
      left
    when /RIGHT/
      right
    when /^REPORT$/
      report
    end
  end

  # places the robot on the simulator
  def place
    command = input[1]
    return true if command.nil?

    input_commands = command.split(',')
    x, y, facing = input_commands
    @simulator ||= Simulator.new
    @simulator.place(x.to_i, y.to_i, facing)
    true
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
      @console_interface.output(simulator.report) unless simulator.report.nil?
    end
  end

  private

  attr_reader :simulator, :input

  def execute_operation
    if defined?(@simulator)
      yield
    else
      puts 'Please place the robot first'
    end
    true
  end
end
