# frozen_string_literal: true

class Radar
  MATCH_THRESHOLD = 50 # Percentage to determine valid match passes
  POSITION_OFFSET = 75 # Percentage offset for scanning positions
  MATCH_PERCENTAGES = [90, 50, 30].freeze # Varying match percentages for detection

  def invaders
    [Crab, Squid]
  end

  def scan(sample)
    radar_sample = RadarSample.new(sample)

    invaders.each do |invader_class|
      invader = invader_class.new
      scan_invader(invader, radar_sample)
    end
  end

  private

  def scan_invader(invader, radar_sample)
    offset_columns = calculate_offset(invader.columns)
    offset_rows = calculate_offset(invader.rows)

    MATCH_PERCENTAGES.each do |match_percentage|
      initial_position = [-offset_columns, -offset_rows]
      end_position = [radar_sample.array.first.length + POSITION_OFFSET, radar_sample.array.length + POSITION_OFFSET]

      while initial_position[1] < end_position[1]
        scan_rows(invader, initial_position, match_percentage, radar_sample)
        initial_position[1] += 1
        initial_position[0] = -offset_columns
      end
    end
  end

  def calculate_offset(value)
    (value * POSITION_OFFSET / 100).ceil
  end

  def scan_rows(invader, initial_position, match_percentage, radar_sample)
    while initial_position[0] < radar_sample.array.first.length + POSITION_OFFSET
      scan_section(initial_position, invader, match_percentage, radar_sample)
      initial_position[0] += 1
    end
  end

  def scan_section(initial_position, invader, match_percentage, radar_sample)
    matches, first_match, last_position = 0, nil, [0, 0]

    (initial_position[1]...(initial_position[1] + invader.rows)).each do |row_index|
      (initial_position[0]...(initial_position[0] + invader.columns)).each do |col_index|
        char = radar_sample.char_at(row_index, col_index)
        next unless radar_sample.valid_match?(char, invader.array[row_index - initial_position[1]][col_index - initial_position[0]])

        matches += 1
        first_match ||= [row_index, col_index]
        last_position = [[row_index, last_position[0]].max, [col_index, last_position[1]].max]
      end
    end

    return unless found_match?(matches, first_match, last_position, invader, match_percentage)

    puts "(#{first_match.join(",")})"
    radar_sample.clear_positions([first_match, last_position])
  end

  def found_match?(matches, first_match, last_position, invader, match_percentage)
    return false if matches.zero? || matches < invader.chars_count * match_percentage / 100

    (matches.to_f / section_size(first_match, last_position) * 100) > MATCH_THRESHOLD
  end

  def section_size(initial_position, last_position)
    return 0 if initial_position.nil? || last_position.nil?

    (last_position[0] - initial_position[0] + 1) * (last_position[1] - initial_position[1] + 1)
  end
end
