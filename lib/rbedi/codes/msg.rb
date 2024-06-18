module RBEDI
  module Codes
    module MSG
      extend CodeSet

      SEGMENT_POSITIONS = {
        1 => :message_text,
        2 => :printer_carriage_control_code,
        3 => :lines_to_advance_before_printing
      }

      CODES = {
        2 => {
          "aa" => :advance_the_specified_number_of_lines_before_print,
          "at" => :advanced_three_lines_before_print,
          "ds" => :advance_two_lines_before_print,
          "lc" => :line_continuation,
          "np" => :advance_to_next_page_before_print,
          "ns" => :no_advance_before_print,
          "ss" => :advance_to_new_line_before_print,
        }
      }
    end
  end
end
