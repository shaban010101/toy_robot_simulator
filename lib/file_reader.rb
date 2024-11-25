# frozen_string_literal: true

require_relative 'operation_executor'
require_relative 'config'

# The FileReader reads a file and executes commands based on them
class FileReader
  def initialize(file, console_interface: ConsoleInterface.new)
    @file = file
    @console_interface = console_interface
  end

  # Uses a text file as input and reads its lines executing commands it knows
  def run
    return unless valid_file?

    f = File.foreach(file)
    f.each_entry.with_index do |line, index|
      line_number = index + 1
      inputs = line.split
      unless operation_executor.call(inputs)
        message = "Unrecognised command '#{inputs.join(" ")}' on line #{line_number}"
        @console_interface.output(message)
      end
    end
  end

  private

  attr_reader :file

  def valid_file?
    unless file && File.exist?(file)
      @console_interface.output('Please enter a file which exists')
      return false
    end

    unless Config::SUPPORTED_FILE_TYPES.include?(File.extname(file))
      @console_interface.output('Please only use a text file')
      return false
    end

    true
  end

  def operation_executor
    @operation_executor ||= OperationExecutor.new(console_interface: @console_interface)
  end
end
