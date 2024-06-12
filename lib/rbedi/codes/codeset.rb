module RBEDI
  module Codes
    module CodeSet
      def segment_position(pos)
        if pos.is_a?(Integer)
          self::SEGMENT_POSITIONS[pos]
        else
          self::SEGMENT_POSITIONS.key(pos)
        end
      end

      def code(pos, code)
        pos = self::SEGMENT_POSITIONS.key(pos) unless pos.is_a?(Integer)
        codes = self::CODES[pos]

        return nil unless codes
        return nil if code.nil?

        if code.is_a?(String)
          codes[code.downcase]
        else
          codes.key(code).upcase
        end
      end
    end
  end
end
