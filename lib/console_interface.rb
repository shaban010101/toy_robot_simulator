class ConsoleInterface
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def output(string, method: :puts)
    @output.public_send(method, string)
  end

  def input
    @input.gets.chomp.split(' ')
  end
end
