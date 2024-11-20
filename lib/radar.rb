# frozen_string_literal: true

class Radar
  THRESHOLD = 50 # Percentage
  OFFSET = 75 # Percentage

  def invaders
    [Crab, Squid]
  end

  def scan(sample)
    @pass_array = sample.split("\n")

    invaders.each do |invader|
      invader = invader.new

      offset_columns = (invader.columns * OFFSET / 100).ceil
      offset_rows = (invader.rows * OFFSET / 100).ceil

      [90, 25].each do |match_count|
        # Percentage - how much minimally invader should be present to detect

        initial_position = [offset_columns * -1, offset_rows * -1] # Starting position
        end_position = [@pass_array.first.length + OFFSET, @pass_array.length + OFFSET]

        # TODO Class Sample, for calculating initial and end position using offset

        while initial_position[1] < end_position[1]
          while initial_position[0] < end_position[0]
            result = single_pass(@pass_array, initial_position, invader, match_count)
            initial_position[0] += 1

            if result
              set_positions(result)
              # puts pass_array.join("\n")
            end
          end
          initial_position[0] = 0 # Reset column index for the next row
          initial_position[1] += 1 # Move to the next row
        end
      end
    end
  end

  def single_pass(pass_array, initial_position, invader, match_count)
    matches = 0
    last_position = []
    first_match = []

    (initial_position[0]..(initial_position[0] + invader.rows - 1)).each do |row_index|
      (initial_position[1]..(initial_position[1] + invader.columns - 1)).each do |col_index|
        char = (row_index < 0 || col_index < 0 || pass_array[row_index].nil?) ? "" : pass_array[row_index][col_index]

        next if char == "x"

        next unless invader.array[row_index] && invader.array[row_index][col_index]

        next unless char == invader.array[row_index - initial_position[0]][col_index - initial_position[1]]

        matches += 1

        first_match = [row_index, col_index] if first_match.empty?
        last_position = [row_index, col_index]
      end
    end

    return if matches.zero?

    return if first_match.empty? || last_position.empty?

    return if matches < invader.chars_count * match_count.to_f / 100

    if (matches.to_f / pass_size_chars(first_match, last_position) * 100) > THRESHOLD
      puts "(#{first_match.join(",")})"

      [first_match, last_position]
    end
  end

  def pass_size_chars(initial_position, last_position)
    pass_size = last_position.zip(initial_position).map { |a, b| a - b } # get the size of pass
    pass_size.map! { |x| x + 1 } # Give + 1

    pass_size[0] * pass_size[1] # Total sample size in chars
  end

  def set_positions(coordinates)
    (coordinates[0][0]..coordinates[1][0]).each do |x|
      (coordinates[0][1]..coordinates[1][1]).each do |y|
        @pass_array[x][y] = "x"
      end
    end
  end
end
