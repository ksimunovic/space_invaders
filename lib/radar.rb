# frozen_string_literal: true

class Radar
  THRESHOLD = 50 # Percentage
  OFFSET = 75 # Percentage

  def invaders
    [Crab, Squid]
  end

  def scan(sample)
    @pass_array = sample.split("\n")

    invaders.each do |invader_class|
      invader = invader_class.new
      scan_invader(invader)
    end
  end

  private

  def scan_invader(invader)
    offset_columns = (invader.columns * OFFSET / 100).ceil
    offset_rows = (invader.rows * OFFSET / 100).ceil

    [90, 50, 30].each do |match_count|
      initial_position = [-offset_columns, -offset_rows]
      end_position = [@pass_array.first.length + OFFSET, @pass_array.length + OFFSET]

      while initial_position[1] < end_position[1]
        scan_rows(invader, initial_position, match_count)
        initial_position[1] += 1
        initial_position[0] = -offset_columns
      end
    end
  end

  def scan_rows(invader, initial_position, match_count)
    while initial_position[0] < @pass_array.first.length + OFFSET
      result = single_pass(initial_position, invader, match_count)
      set_positions(result) if result
      initial_position[0] += 1
    end
  end

  def single_pass(initial_position, invader, match_count)
    matches = 0
    first_match = nil
    last_position = [0, 0]

    (initial_position[1]...(initial_position[1] + invader.rows)).each do |row_index|
      (initial_position[0]...(initial_position[0] + invader.columns)).each do |col_index|
        char = pass_char(row_index, col_index)
        next unless valid_match?(char, invader.array[row_index - initial_position[1]][col_index - initial_position[0]])

        matches += 1
        first_match ||= [row_index, col_index]

        last_position = [[row_index, last_position[0]].max, [col_index, last_position[1]].max]
      end
    end

    return unless matches > 0 && matches >= invader.chars_count * match_count / 100

    return unless (matches.to_f / pass_size_chars(first_match, last_position) * 100) > THRESHOLD

    puts "(#{first_match.join(",")})"
    [first_match, last_position]
  end

  def pass_char(row_index, col_index)
    return "" if row_index < 0 || col_index < 0 || @pass_array[row_index].nil?
    @pass_array[row_index][col_index]
  end

  def valid_match?(char, invader_char)
    char != "x" && char == invader_char
  end

  def pass_size_chars(initial_position, last_position)
    return 0 if initial_position.nil? || last_position.nil?

    (last_position[0] - initial_position[0] + 1) * (last_position[1] - initial_position[1] + 1)
  end

  def set_positions(coordinates)
    ((coordinates[0][0])...(coordinates[1][0] + 1)).each do |x|
      ((coordinates[0][1])...(coordinates[1][1] + 1)).each do |y|
        @pass_array[x][y] = "x"
      end
    end
  end
end
