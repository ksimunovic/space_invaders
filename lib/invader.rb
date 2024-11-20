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

  def offset_position
  end
end
