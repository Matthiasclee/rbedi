module RBEDI
  class TransactionEnvelope
    def initialize(
      submitter_id:,
      receiver_id:,
      functional_groups: [],
      interchange_control_number:,
      date_time: DateTime.now,
      repetition_separator: ?^,
      component_separator: ?:,
      usage_indicator: :production,
      acknowledgement_requested: false
    )
      @submitter_id = submitter_id
      @receiver_id = receiver_id
      @repetition_separator = repetition_separator
      @component_separator = component_separator
      @interchange_control_number = "%09d" % interchange_control_number
      @acknowledgement_requested = acknowledgement_requested ? 1 : 0
      @date_time = EDIDateTime.new(date_time)
      @functional_groups = functional_groups
      @usage_indicator = usage_indicator
    end

    def to_s
      header.to_s +
        @functional_groups.map(&:to_s).join +
        trailer.to_s
    end

    def header
      Segment.new(
        INTERCHANGE_CONTROL_HEADER_SEGMENT_NAME,
        header_elements
      )
    end

    def trailer
      Segment.new(
        INTERCHANGE_CONTROL_TRAILER_SEGMENT_NAME,
        trailer_elements
      )
    end

    attr_reader :submitter_id, :receiver_id, :repetition_separator, :component_separator, :date_time, :interchange_control_number, :acknowledgement_requested
    attr_accessor :functional_groups

    private

    def header_elements
      [
        NO_INFORMATION_PRESENT_CODE,
        " " * 10,
        NO_INFORMATION_PRESENT_CODE,
        " " * 10,
        MUTUALLY_DEFINED_CODE,
        @submitter_id.ljust(15),
        MUTUALLY_DEFINED_CODE,
        "NVMED".ljust(15),
        @date_time.yymmdd,
        @date_time.hhmm,
        @repetition_separator,
        INTERCHANGE_CONTROL_VERSION_NUMBER,
        @interchange_control_number,
        @acknowledgement_requested,
        @usage_indicator,
        @component_separator,
      ]
    end

    def trailer_elements
      [
        @functional_groups.length,
        @interchange_control_number,
      ]
    end
  end
end
