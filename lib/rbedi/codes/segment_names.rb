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
        "LS" => :loop_header,
        "LE" => :loop_trailer,
        "BHT" => :begin_hierarchial_transaction,
        "HL" => :hierarchial_level,
        "NM1" => :individual_or_organization_name,
        "N3" => :party_location,
        "N4" => :geographic_location,
        "PER" => :administrative_communications_contact,
        "TRN" => :trace,
        "MSG" => :message_text,
        "DMG" => :demographic_information,
        "REF" => :reference_information,
        "DTP" => :date_time_period,
        "EQ" => :eligibility_or_benefit_inquiry,
        "EB" => :eligibility_or_benefit_information,
        "AAA" => :request_validation,
        "AK1" => :functional_group_response_header,
        "AK9" => :functional_group_response_trailer,
        "AK2" => :transaction_set_response_header,
        "IK3" => :implementation_data_segment_note,
        "IK4" => :implementation_data_element_note,
        "IK5" => :implementation_transaction_set_response_trailer,
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
