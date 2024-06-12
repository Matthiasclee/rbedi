module RBEDI
  module Codes
    module SegmentNames
      SEGMENT_NAMES = {
        "ISA" => :interchange_control_header
      }
      
      def self.segment_name(segment)
        if segment.is_a?(Symbol)
          SEGMENT_NAMES.key(segment)
        else
          SEGMENT_NAMES[segment].upcase
        end
      end
    end
  end
end
