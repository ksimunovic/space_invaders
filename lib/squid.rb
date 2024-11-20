# frozen_string_literal: true

require_relative "invader"

class Squid < Invader
  PATTERN = "--o-----o--
             ---o---o---
             --ooooooo--
             -oo-ooo-oo-
             ooooooooooo
             o-ooooooo-o
             o-o-----o-o
             ---oo-oo---".delete(" ")
end
