module RBEDI
  module Codes
    module IK4
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :position_in_segment,
        2 => :data_element_reference_number,
        3 => :implementation_data_element_syntax_error_code,
        4 => :copy_of_bad_data_element
      }

      CODES = {
        3 => {
          "1" => :required_data_element_missing,
          "2" => :conditional_required_data_element_missing,
          "3" => :too_many_data_elements,
          "4" => :data_element_too_short,
          "5" => :data_element_too_long,
          "6" => :invalid_character_in_data_element,
          "7" => :invalid_code_value,
          "8" => :invalid_date,
          "9" => :invalid_time,
          "10" => :exclusion_condition_violated,
          "12" => :too_many_repetitions,
          "13" => :too_many_components,
          "i6" => :code_value_not_used_in_implementation,
          "i9" => :implementation_dependent_data_element_missing,
          "i10" => :implementation_not_used_data_element_present,
          "i11" => :implementation_too_few_repetitions,
          "i12" => :implementation_pattern_match_failure,
          "i13" => :implementation_dependent_not_used_data_element_present,
        }
      }
    end
  end
end
