require "rspec"

RSpec.describe Radar do
  describe "full match detection" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection on left side" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection on right side" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(0,1)\n").to_stdout
    end
  end

  describe "partial match detection with top offset" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(0,0)\n").to_stdout
    end
  end

  describe "partial match detection with top offset in the middle" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(0,10)\n").to_stdout
    end
  end

  describe "partial match detection with bottom offset in the middle" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(3,4)\n").to_stdout
    end
  end

  describe "multiple invader detection with top offset" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(3,10)\n(0,0)\n").to_stdout
    end
  end

  describe "detection of multiple invaders" do
    let(:radar) { described_class.new }
    let(:grid) {
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
      expect { radar.scan(grid) }.to output("(3,10)\n(3,81)\n(0,0)\n").to_stdout
    end
  end

  describe "detection of multiple different invaders" do
    let(:radar) { described_class.new }
    let(:grid) {
      "oooo------------------------------------------------
       oo-oo-----------------------------------------------
       ooooo-----------------------------------o-----o-----
       --o----------oo--------------------------o---o------
       oo-o--------oooo------------------------ooooooo-----
       --o-o------oooooo----------------------oo-ooo-oo----
       ----------oo-oo-oo--------------------ooooooooooo---
       ----------oooooooo--------------------o-ooooooo-o---
       ------------o--o----------------------o-o-----o-o---
       -----------o-oo-o------------------------oo-oo------
       ----------o-o--o-o----------------------------------
       ----------------------------------------------------"
        .delete(" ")
    }

    it "detects invaders at positions (3,10), (3,38), and (0,0)" do
      expect { radar.scan(grid) }.to output("(3,10)\n(3,38)\n(0,0)\n").to_stdout
    end
  end

  describe "official test case" do
    let(:radar) { described_class.new }

    let(:grid) { File.read("spec/fixtures/official_grid.txt").delete(" ") }

    it "detects all invaders" do
      expect { radar.scan(grid) }.to output("(28,16)\n(15,35)\n(0,42)\n(41,82)\n(34,6)\n(0,9)\n(2,17)\n(41,17)\n(28,34)\n(1,51)\n(11,53)\n(14,61)\n(31,64)\n(3,70)\n(1,77)\n(14,82)\n(12,90)\n(19,1)\n(0,19)\n(26,49)\n(20,22)\n(35,24)\n(0,29)\n(41,45)\n(23,69)\n(0,87)\n(10,14)\n(8,26)\n(17,43)\n(32,82)\n").to_stdout
    end
  end
end
