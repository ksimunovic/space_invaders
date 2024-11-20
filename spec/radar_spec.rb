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

    it "detects invader at position (0,0)" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection on left side" do
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

    it "detects invader at position (0,0)" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection on right side" do
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

    it "detects invader at position (0,1)" do
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

    it "detects invader at position (0,0)" do
      expect { radar.scan(radar_sample) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection with top offset in the middle" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "----------oo-oo-oo--------
       ----------oooooooo--------
       ------------o--o----------
       -----------o-oo-o---------
       ----------o-o--o-o--------
       --------------------------
       --------------------------
       --------------------------
       --------------------------
       --------------------------
       --------------------------".delete(" ")
    }

    it "detects invader at position (0,10)" do
      expect { radar.scan(radar_sample) }.to output("(0,10)\n").to_stdout
    end
  end

  describe "partial match detection with bottom offset in the middle" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "------------------
       ------------------
       ------------------
       -------oo---------
       ------oooo--------
       -----oooooo-------
       ----oo-oo-oo------
       ----oooooooo------".delete(" ")
    }

    it "detects invader at position (3,4)" do
      expect { radar.scan(radar_sample) }.to output("(3,4)\n").to_stdout
    end
  end

  describe "multiple invader detection with top offset" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "oooo----------------
       oo-oo---------------
       ooooo---------------
       --o----------oo-----
       oo-o--------oooo----
       --o-o------oooooo---
       ----------oo-oo-oo--
       ----------oooooooo--
       ------------o--o----
       -----------o-oo-o---
       ----------o-o--o-o--
       --------------------".delete(" ")
    }

    it "detects invaders at positions (3,10) and (0,0)" do
      expect { radar.scan(radar_sample) }.to output("(3,10)\n(0,0)\n").to_stdout
    end
  end

  describe "detection of multiple invaders" do
    let(:radar) { described_class.new }
    let(:radar_sample) {
      "oooo-------------------------------------------------------------------------------------------
       oo-oo------------------------------------------------------------------------------------------
       ooooo------------------------------------------------------------------------------------------
       --o----------oo---------------------------------------------------------------------oo---------
       oo-o--------oooo-------------------------------------------------------------------oooo--------
       --o-o------oooooo-----------------------------------------------------------------oooooo-------
       ----------oo-oo-oo---------------------------------------------------------------oo-oo-oo------
       ----------oooooooo---------------------------------------------------------------oooooooo------
       ------------o--o-------------------------------------------------------------------o--o--------
       -----------o-oo-o-----------------------------------------------------------------o-oo-o-------
       ----------o-o--o-o---------------------------------------------------------------o-o--o-o------
       -----------------------------------------------------------------------------------------------"
        .delete(" ")
    }

    it "detects invaders at positions (3,10), (3,81), and (0,0)" do
      expect { radar.scan(radar_sample) }.to output("(3,10)\n(3,81)\n(0,0)\n").to_stdout
    end
  end
end
