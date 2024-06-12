module RBEDI
  module Codes
    module SegmentNames
      SEGMENT_NAMES = {
        "ISA" => :interchange_control_header,
        "IEA" => :interchange_control_trailer,
        "GS" => :functional_group_header,
        "GE" => :functional_group_trailer,
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
