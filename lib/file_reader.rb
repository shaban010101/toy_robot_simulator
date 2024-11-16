require_relative 'operation_executor'

# The FileReader reads a file and executes commands based on them
class FileReader
  # Uses a text file as input and read its lines executing commands it knows
  def run(file)
    f = File.foreach(file)
    f.each_entry.with_index do |line, index|
      inputs = line.split(" ")

      unless operation_executor.call(inputs)
        puts "unrecognised command: #{line} on line #{index+1} "
      end
    end
  end

  private

  def operation_executor
    @operation_executor ||= OperationExecutor.new
  end
end
