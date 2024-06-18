module RBEDI
  module Codes
    module IK3
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :segment_id_code,
        2 => :segment_position_in_transaction_set,
        3 => :loop_identifier_code,
        4 => :implementation_segment_syntax_error_code
      }

      CODES = {
        1 => {
          "1" => :unrecognized_segment_id,
          "2" => :unexpected_segment,
          "3" => :required_segment_missing,
          "4" => :loop_occurs_over_maximum_times,
          "5" => :segment_exceeds_maximum_use,
          "6" => :segment_not_in_defined_transaction_set,
          "7" => :segment_not_in_proper_sequence,
          "8" => :segment_has_data_element_errors,
          "i4" => :implementation_not_used_segment_present,
          "i6" => :implementation_dependent_segment_missing,
          "i7" => :implementation_loop_occurs_under_minimum_times,
          "i8" => :implementation_segment_below_minimum_use,
          "i9" => :implementation_dependent_not_used_segment_present,
        }
      }
    end
  end
end
