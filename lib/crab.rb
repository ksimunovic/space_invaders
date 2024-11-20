# frozen_string_literal: true

require_relative "invader"

class Crab < Invader
  PATTERN = "---oo---
     --oooo--
     -oooooo-
     oo-oo-oo
     oooooooo
     --o--o--
     -o-oo-o-
     o-o--o-o".delete(" ")
end
