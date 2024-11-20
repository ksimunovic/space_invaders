# frozen_string_literal: true

class RadarSample
  attr_reader :array

  def initialize(sample)
    @array = sample.split("\n")
  end

  def char_at(row_index, col_index)
    return "" if row_index < 0 || col_index < 0 || @array[row_index].nil?

    @array[row_index][col_index]
  end

  def clear_positions(coordinates)
    ((coordinates[0][0])...(coordinates[1][0] + 1)).each do |x|
      ((coordinates[0][1])...(coordinates[1][1] + 1)).each do |y|
        @array[x][y] = "x" if x < @array.length && y < @array[x].length
      end
    end
  end

  def valid_match?(char, invader_char)
    char != "x" && char == invader_char
  end
end
