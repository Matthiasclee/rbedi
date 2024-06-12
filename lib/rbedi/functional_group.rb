module RBEDI
  class FunctionalGroup
    include Codes

    def initialize(
      group_control_number:,
      functional_identifier_code:,
      submitter_id:,
      receiver_id:,
      date_time: DateTime.now,
      transaction_sets: []
    )
      @group_control_number = group_control_number
      @functional_identifier_code = functional_identifier_code
      @submitter_id = submitter_id
      @receiver_id = receiver_id
      @transaction_sets = transaction_sets
      @date_time = EDIDateTime.new(date_time)
    end

    def to_s
      header.to_s +
        @transaction_sets.map(&:to_s).join +
        trailer.to_s
    end

    def header
      Segment.new(
        FUNCTIONAL_GROUP_HEADER_SEGMENT_NAME,
        header_elements
      )
    end

    def trailer
      Segment.new(
        FUNCTIONAL_GROUP_TRAILER_SEGMENT_NAME,
        trailer_elements
      )
    end

    attr_reader :group_control_number, :submitter_id, :receiver_id, :date_time, :functional_identifier_code
    attr_accessor :transaction_sets

    private

    def header_elements
      [
        @functional_identifier_code,
        @submitter_id,
        @receiver_id,
        @date_time.ccyymmdd,
        @date_time.hhmm,
        @group_control_number,
        ACCREDITED_STANDARDS_COMMITTEE_X12_CODE,
        VERSION_CODE,
      ]
    end

    def trailer_elements
      [
        @transaction_sets.length,
        @group_control_number,
      ]
    end
  end
end
