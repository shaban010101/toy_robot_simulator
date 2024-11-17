# frozen_string_literal: true

require_relative 'operation_executor'

# The FileReader reads a file and executes commands based on them
class FileReader
  def initialize(file)
    @file = file
  end

  # Uses a text file as input and read its lines executing commands it knows
  def run
    return unless valid_file?

    f = File.foreach(file)
    f.each_entry.with_index do |line, index|
      inputs = line.split

      puts "Unrecognised command '#{inputs.join(" ")}' on line #{index+1}" unless operation_executor.call(inputs)
    end
  end

  private

  attr_reader :file

  def valid_file?
    unless file && File.exist?(file)
      puts 'Please enter a file which exists'
      return false
    end

    unless File.extname(file) == '.txt'
      puts 'Please only use a text file'
      return false
    end

    true
  end

  def operation_executor = @operation_executor ||= OperationExecutor.new
end
