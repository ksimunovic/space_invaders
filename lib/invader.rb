# frozen_string_literal: true

class Invader
  def pattern
    self.class::PATTERN
  end

  def array
    pattern.split("\n")
  end

  def chars_count
    pattern.delete("\n").length
  end

  def columns
    array.first.length
  end

  def rows
    array.length
  end

  def char_at(row_index, col_index)
    return "" if row_index < 0 || col_index < 0 || array[row_index].nil?

    array[row_index][col_index]
  end
end
