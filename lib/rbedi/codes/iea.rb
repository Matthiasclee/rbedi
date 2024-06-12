module RBEDI
  module Codes
    module IEA
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :functional_group_count,
        2 => :interchange_control_number,
      }

      CODES = {}
    end
  end
end
