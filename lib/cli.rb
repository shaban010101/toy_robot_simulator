require_relative 'operation_executor'
require_relative 'console_interface'
# ARGV.clear

class CLI
  HELP_TEXT = <<~HELP_TEXT
      ? - Help
      PLACE - Places the robot on a square using the follow coordinates X,Y, Direction e.g. 0,0, SOUTH
      MOVE - Moves the robot one place forward
      LEFT - Turn the direction the robot faces to the left
      RIGHT - Turn the direction the robot faces to the right
      R - Show the current coordinates
      X - Terminate the session
  HELP_TEXT

  def initialize(console_interface: ConsoleInterface.new)
    @console_interface = console_interface
  end

  def run
    @running = true
    @console_interface.output('type ? for help')
    while @running
      @console_interface.output('> ')

      input = @console_interface.input

      case input.first
      when '?'
        show_help
      when 'X'
        exit_console
      else
        unless operation_executor.call(input)
          @console_interface.output("Unrecognised Command '#{input.first}'")
        end
      end
    end
  end

  private

  def operation_executor = @operation_executor ||= OperationExecutor.new(console_interface: @console_interface)

  def exit_console
    @console_interface.output('EXITING')
    @running = false
  end

  def show_help = @console_interface.output(HELP_TEXT)
end