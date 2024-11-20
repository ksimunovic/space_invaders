# frozen_string_literal: true

require "rspec"

RSpec.describe Squid do
  let(:invader) { described_class.new }

  describe "#pattern" do
    it "returns the pattern of the invader" do
      expect(invader.pattern).to eq("--o-----o--\n---o---o---\n--ooooooo--\n-oo-ooo-oo-\nooooooooooo\no-ooooooo-o\no-o-----o-o\n---oo-oo---")
    end
  end

  describe "#array" do
    it "returns the pattern as an array" do
      expect(invader.array).to eq([
        "--o-----o--",
        "---o---o---",
        "--ooooooo--",
        "-oo-ooo-oo-",
        "ooooooooooo",
        "o-ooooooo-o",
        "o-o-----o-o",
        "---oo-oo---"
      ])
    end
  end

  describe "#chars_count" do
    it "returns the number of characters in the pattern" do
      expect(invader.chars_count).to eq(88)
    end
  end

  describe "#columns" do
    it "returns the number of columns in the pattern" do
      expect(invader.columns).to eq(11)
    end
  end

  describe "#rows" do
    it "returns the number of rows in the pattern" do
      expect(invader.rows).to eq(8)
    end
  end
end
