# frozen_string_literal: true

require "rspec"

RSpec.describe "Invader" do
  describe "#initialize" do
    it 'outputs "Invader"' do
      expect { Invader.new }.to output("Invader\n").to_stdout
    end
  end
end
