require_relative "lib/radar"
require_relative "lib/radar_grid"
require_relative "lib/crab"
require_relative "lib/squid"
require_relative "lib/invader"

if ARGV.empty?
  puts "Usage: ruby run_radar.rb <path_to_sample_file>"
  exit
end

sample_file = ARGV[0]

if File.exist?(sample_file)
  sample_text = File.read(sample_file)
  radar = Radar.new
  radar.scan(sample_text)
else
  puts "File not found: #{sample_file}"
end
