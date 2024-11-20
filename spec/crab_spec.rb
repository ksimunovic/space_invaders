# frozen_string_literal: true

require "rspec"

RSpec.describe Crab do
  let(:invader) { described_class.new }

  describe "#pattern" do
    it "returns the pattern of the invader" do
      expect(invader.pattern).to eq("---oo---\n--oooo--\n-oooooo-\noo-oo-oo\noooooooo\n--o--o--\n-o-oo-o-\no-o--o-o")
    end
  end

  describe "#array" do
    it "returns the pattern as an array" do
      expect(invader.array).to eq([
        "---oo---",
        "--oooo--",
        "-oooooo-",
        "oo-oo-oo",
        "oooooooo",
        "--o--o--",
        "-o-oo-o-",
        "o-o--o-o"
      ])
    end
  end

  describe "#chars_count" do
    it "returns the number of characters in the pattern" do
      expect(invader.chars_count).to eq(64)
    end
  end

  describe "#columns" do
    it "returns the number of columns in the pattern" do
      expect(invader.columns).to eq(8)
    end
  end

  describe "#rows" do
    it "returns the number of rows in the pattern" do
      expect(invader.rows).to eq(8)
    end
  end
end
