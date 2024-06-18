module RBEDI
  module Codes
    module SegmentNames
      SEGMENT_NAMES = {
        "ISA" => :interchange_control_header,
        "IEA" => :interchange_control_trailer,
        "GS" => :functional_group_header,
        "GE" => :functional_group_trailer,
        "ST" => :transaction_set_header,
        "SE" => :transaction_set_trailer,
        "BHT" => :begin_heirarchial_transaction,
        "HL" => :heirarchial_level,
        "NM1" => :individual_or_organization_name,
        "TRN" => :trace,
        "DMG" => :demographic_information,
        "REF" => :reference_information,
        "DTP" => :date_time_period,
        "EQ" => :eligibility_or_benefit_inquiry,
        "EB" => :eligibility_or_benefit_information,
        "AAA" => :request_validation,
        "AK1" => :functional_group_response_header,
        "AK9" => :functional_group_response_trailer,
        "AK2" => :transaction_set_response_header,
      }
      
      def self.segment_name(segment)
        if segment.is_a?(Symbol)
          SEGMENT_NAMES.key(segment)
        else
          SEGMENT_NAMES[segment]
        end
      end
    end
  end
end
