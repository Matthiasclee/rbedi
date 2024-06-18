module RBEDI
  module Codes
    module IK5
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :transaction_set_acknowledgement_code,
        2 => :implementation_transaction_set_syntax_error_code_1,
        3 => :implementation_transaction_set_syntax_error_code_2,
        4 => :implementation_transaction_set_syntax_error_code_3,
        5 => :implementation_transaction_set_syntax_error_code_4,
        6 => :implementation_transaction_set_syntax_error_code_5,
      }

      CODES = {
        1 => {
          "a" => :accepted,
          "e" => :accepted_but_errors_were_noted,
          "m" => :rejected_message_authentication_code_mac_failed,
          "r" => :rejected,
          "w" => :rejected_assurance_failed_validity_tests,
          "x" => :rejected_content_after_decryption_could_not_be_analyzed,
        },
        2 => {
					"1" => :transaction_set_not_supported,
					"2" => :transaction_set_trailer_missing,
					"3" => :transaction_set_control_number_in_header_and_trailer_do_not_match,
					"4" => :number_of_included_segments_does_not_match_actual_count,
					"5" => :one_or_more_segments_in_error,
					"6" => :missing_or_invalid_transaction_set_identifier,
					"7" => :missing_or_invalid_transaction_set_control_number,
					"8" => :authentication_key_name_unknown,
					"9" => :encryption_key_name_unknown,
					"10" => :requested_service_authentication_or_encrypted_not_available,
					"11" => :unknown_security_recipient,
					"12" => :incorrect_message_length_encryption_only,
					"13" => :message_authentication_code_failed,
					"15" => :unknown_security_originator,
					"16" => :syntax_error_in_decrypted_text,
					"17" => :security_not_supported,
					"18" => :transaction_set_not_in_functional_group,
					"19" => :invalid_transaction_set_implementation_convention_reference,
					"23" => :transaction_set_control_number_not_unique_within_the_functional_group,
					"24" => :s3e_security_end_segment_missing_for_s3s_security_start_segment,
					"25" => :s3s_security_start_segment_missing_for_s3e_security_end_segment,
					"26" => :s4e_security_end_segment_missing_for_s4s_security_start_segment,
					"27" => :s4s_security_start_segment_missing_for_s4e_security_end_segment,
					"i5" => :implementation_one_or_more_segments_in_error,
					"i6" => :implementation_convention_not_supported,
        }
      }

      CODES[3], CODES[4], CODES[5], CODES[6] = [CODES[2]]*4
    end
  end
end
