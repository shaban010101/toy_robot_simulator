# frozen_string_literal: true

# Config contains all the config of the Simulator in one place

class Config
  PLUS = :+
  MINUS = :-
  NORTH = 'NORTH'
  SOUTH = 'SOUTH'
  EAST = 'EAST'
  WEST = 'WEST'

  VALID_DIRECTIONS = [NORTH, SOUTH, EAST, WEST].freeze
  # NORTH = UP one row + 1
  # SOUTH = DOWN one row - 1 row
  # WEST = TO the left -1 column
  # EAST = To the right +1 column
  FACE_INDEX_OPERATION = {
    NORTH => PLUS,
    SOUTH => MINUS,
    WEST => MINUS,
    EAST => PLUS
  }.freeze
  RIGHT_DIRECTION = {
    NORTH => EAST,
    SOUTH => WEST,
    EAST => SOUTH,
    WEST => NORTH
  }.freeze
  LEFT_DIRECTION = {
    NORTH => WEST,
    SOUTH => EAST,
    EAST => NORTH,
    WEST => SOUTH
  }.freeze
  X_SIZE = 5
  Y_SIZE = 5
  TOY = 'X'
  DEFAULT_VALUE = 'O'

  OPERATIONS = {
    'PLACE' => :place,
    'MOVE' => :move,
    'LEFT' => :left,
    'RIGHT' => :right,
    'REPORT' => :report
  }.freeze
  SUPPORTED_FILE_TYPES = %w[.txt].freeze
end
