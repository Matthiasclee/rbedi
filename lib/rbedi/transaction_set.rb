module RBEDI
  class TransactionSet
    include Codes

    def initialize(
      transaction_set_control_number:,
      segments: [],
      transaction_set_identifier_code:,
    )
      @transaction_set_control_number = "%04d" % transaction_set_control_number
      @transaction_set_identifier_code = transaction_set_identifier_code
      @segments = segments
    end

    def to_s
      header.to_s +
        @segments.map(&:to_s).join +
        trailer.to_s
    end

    def header
      Segment.new(
        :transaction_set_header,
        transaction_set_identifier_code: @transaction_set_identifier_code,
        transaction_set_control_number: @transaction_set_control_number,
        implementation_convention_reference: Codes::VERSION_CODE
      )
    end

    def trailer
      Segment.new(
        :transaction_set_trailer,
        segments_count: @segments.length + 2,
        transaction_set_control_number: @transaction_set_control_number
      )
    end

    attr_accessor :transaction_set_control_number, :transaction_set_identifier_code, :segments
  end
end
