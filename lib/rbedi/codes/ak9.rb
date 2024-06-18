module RBEDI
  module Codes
    module AK9
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :functional_group_acknowledgement_code,
        2 => :included_transaction_sets_count,
        3 => :received_transaction_sets_count,
        4 => :accepted_transaction_sets_count,
        5 => :functional_group_syntax_error_code_1,
        6 => :functional_group_syntax_error_code_2,
        7 => :functional_group_syntax_error_code_3,
        8 => :functional_group_syntax_error_code_4,
        9 => :functional_group_syntax_error_code_5,
      }

      CODES = {
        1 => {
          "a" => :accepted,
          "e" => :accepted_but_errors_were_noted,
          "m" => :rejected_message_authentication_code_mac_failed,
          "p" => :partially_accepted_at_least_one_transaction_set_was_rejected,
          "r" => :rejected,
          "w" => :rejected_assurance_failed_validity_tests,
          "x" => :rejected_content_after_decryption_could_not_be_analyzed,
        },
        5 => {
          "1" => :functional_group_not_supported,
          "2" => :functional_group_version_not_supported,
          "3" => :functional_group_trailer_missing,
          "4" => :group_control_number_in_the_functional_group_header_and_trailer_do_not_agree,
          "5" => :number_of_included_transaction_sets_does_not_match_actual_count,
          "6" => :group_control_number_violates_syntax,
          "10" => :authentication_key_name_unknown,
          "11" => :encryption_key_name_unknown,
          "12" => :requested_service_authentication_or_encryption_not_available,
          "13" => :unknown_security_recipient,
          "14" => :unknown_security_originator,
          "15" => :syntax_error_in_decrypted_text,
          "16" => :security_not_supported,
          "17" => :incorrect_message_length_encryption_only,
          "18" => :message_authentication_code_failed,
          "19" => :functional_group_control_number_not_unique_within_interchange,
          "23" => :s3e_security_end_segment_missing_for_s3s_security_start_segment,
          "24" => :s3s_security_start_segment_missing_for_s3e_end_segment,
          "25" => :s4e_security_end_segment_missing_for_s4s_security_start_segment,
          "26" => :s4s_security_start_segment_missing_for_s4e_security_end_segment,
        }
      }

      CODES[6], CODES[7], CODES[8], CODES[9] = [CODES[5]]*4
    end
  end
end
