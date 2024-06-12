module RBEDI
  class TransactionSet
    include Codes

    def initialize(
      transaction_set_control_number:,
      segments: [],
      transaction_set_identifier: ELIGIBILITY_REQUEST_TRANSACTION_SET
    )
      @transaction_set_control_number = "%04d" % transaction_set_control_number
      @transaction_set_identifier = transaction_set_identifier
      @segments = segments
    end

    def to_s
      header.to_s +
        @segments.map(&:to_s).join +
        trailer.to_s
    end

    def header
      Segment.new(
        TRANSACTION_SET_HEADER_SEGMENT_NAME,
        header_elements
      )
    end

    def trailer
      Segment.new(
        TRANSACTION_SET_TRAILER_SEGMENT_NAME,
        trailer_elements
      )
    end

    attr_reader :transaction_set_control_number, :transaction_set_identifier
    attr_accessor :segments

    private

    def header_elements
      [
        @transaction_set_identifier,
        @transaction_set_control_number,
        VERSION_CODE,
      ]
    end

    def trailer_elements
      [
        @segments.length + 2,
        @transaction_set_control_number,
      ]
    end
  end
end
