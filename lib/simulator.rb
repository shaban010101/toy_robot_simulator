class Simulator
  def place(x, y, facing)
    @x = x
    @y = y
    @facing = facing
  end

  def report = "#{@x},#{@y},#{@facing}"
end