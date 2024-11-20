# frozen_string_literal: true

class Radar
  MATCH_THRESHOLD = 50 # Percentage to determine valid match passes
  POSITION_OFFSET = 75 # Percentage offset for scanning positions
  MATCH_PERCENTAGES = [90, 75, 55, 30].freeze # Varying match percentages for detection
  CHARS_MATCHED_THRESHOLD = 15 # Minimal number of matched characters for detection

  def invaders
    [Crab, Squid]
  end

  def scan(sample)
    grid = RadarGrid.new(sample)

    invaders.each do |invader_class|
      invader = invader_class.new
      scan_invader(invader, grid)
    end
  end

  private

  def scan_invader(invader, grid)
    @offset_columns = calculate_offset(invader.columns)
    @offset_rows = calculate_offset(invader.rows)

    MATCH_PERCENTAGES.each do |match_percentage|
      initial_position = [-@offset_rows, -@offset_columns]
      end_position = [grid.array.length + @offset_rows, grid.array.first.length + @offset_columns]

      while initial_position[1] < end_position[1]
        scan_rows(invader, initial_position, match_percentage, grid)
        initial_position[1] += 1
        initial_position[0] = -@offset_columns
      end
    end
  end

  def calculate_offset(value)
    (value * POSITION_OFFSET / 100).ceil
  end

  def scan_rows(invader, initial_position, match_percentage, grid)
    while initial_position[0] < grid.array.length + @offset_rows
      scan_section(initial_position, invader, match_percentage, grid)
      initial_position[0] += 1
    end
    # File.write("grid_output.txt", grid.array.join("\n")) # DEBUG
  end

  def scan_section(initial_position, invader, match_percentage, grid)
    matches, first_match, last_position = 0, nil, [0, 0]

    (initial_position[0]...(initial_position[0] + invader.rows)).each do |row_index|
      (initial_position[1]...(initial_position[1] + invader.columns)).each do |col_index|
        detected_char = grid.char_at(row_index, col_index)
        invader_char = invader.char_at(row_index - initial_position[0], col_index - initial_position[1])
        next unless grid.valid_match?(detected_char, invader_char)

        matches += 1
        first_match ||= [row_index, col_index]
        last_position = [[row_index, last_position[0]].max, [col_index, last_position[1]].max]
      end
    end

    return unless valid_match?(matches,
      section_cut(grid.array, first_match, last_position),
      invader, match_percentage)

    puts "(#{first_match.join(",")})"
    grid.clear_positions([first_match, last_position])

    # puts grid.array.join("\n") # DEBUG
    scan_section(initial_position, invader, match_percentage, grid)
  end

  def valid_match?(matches, section, invader, match_percentage)
    return false unless valid_match_count?(matches, invader, match_percentage)
    return false unless enough_matching_chars?(section)

    match_ratio_exceeds_threshold?(matches, section)
  end

  def valid_match_count?(matches, invader, match_percentage)
    matches.positive? && matches >= invader.chars_count * match_percentage.to_f / 100
  end

  def enough_matching_chars?(section)
    section_matched_chars(section) >= CHARS_MATCHED_THRESHOLD
  end

  def match_ratio_exceeds_threshold?(matches, section)
    (matches.to_f / section_size(section) * 100) > MATCH_THRESHOLD
  end

  def section_cut(array, initial_position, last_position)
    return [] if initial_position.nil? || last_position.nil?

    array[initial_position[0]..last_position[0]].map do |row|
      row[initial_position[1]..last_position[1]]
    end
  end

  def section_matched_chars(section)
    chars = []

    section.each do |row|
      chars.concat(row.chars)
    end

    chars.count { |char| char != "-" && char != "x" }
  end

  def section_size(section)
    section.flatten.join.length
  end
end
