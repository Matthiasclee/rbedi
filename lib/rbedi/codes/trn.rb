module RBEDI
  module Codes
    module TRN
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :trace_type_code,
        2 => :reference_identification,
        3 => :originating_company_identifier,
        4 => :second_reference_identification,
      }

      CODES = {
        1 => {
					"1" => :current_transaction,
					"2" => :referenced_transaction,
					"3" => :financial_reassociation,
        }
      }
    end
  end
end
