module RBEDI
  module Codes
    module GE
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :transaction_set_count,
        2 => :group_control_number
      }

      CODES = {}
    end
  end
end
