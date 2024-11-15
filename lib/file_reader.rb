require_relative '../lib/operation_executor'

class FileReader
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
