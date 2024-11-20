require "rspec"

RSpec.describe Radar do
  describe "full match detection" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "---oo---
       --oooo--
       -oooooo-
       oo-oo-oo
       oooooooo
       --o--o--
       -o-oo-o-
       o-o--o-o".delete(" ")
    }

    it "detects invader at starting position" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial end-match detection left side" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "o---------
       oo--------
       ooo-------
       o-oo------
       oooo------
       -o--------
       o-o-------
       -o-o------".delete(" ")
    }

    it "detects invader at starting position" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial end-match detection right side" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "------ooo
       -----oooo
       ----oo-oo
       ----ooooo
       ------o--
       -----o-oo
       ----o-o--
       ---------".delete(" ")
    }

    it "detects invader at starting position " do
      expect { radar.scan(radar_sample) }.to output("(0,1)\n").to_stdout
    end
  end

  describe "partial match detection with top offset" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "oooo-
       oo-oo
       ooooo
       --o--
       oo-o-
       --o-o
       -----
       -----".delete(" ")
    }

    it "detects invader at starting position" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end
end
