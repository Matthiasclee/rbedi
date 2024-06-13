module RBEDI
  module Codes
    module SE
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :segments_count,
        2 => :transaction_set_control_number,
      }

      CODES = {}
    end
  end
end
