require_relative 'config'

class Validation
  def self.legal_move?(x, y)
    (0...Config::X_SIZE).to_a.include?(x) && (0...Config::Y_SIZE).to_a.include?(y)
  end

  def self.supported_direction?(facing)
    Config::VALID_DIRECTIONS.include?(facing)
  end
end