module RBEDI
  class FunctionalGroup
    include Codes

    def initialize(
      group_control_number:,
      functional_identifier_code:,
      application_sender_code:,
      application_receiver_code:,
      date_time: DateTime.now,
      transaction_sets: []
    )
      @group_control_number = group_control_number
      @functional_identifier_code = functional_identifier_code
      @application_sender_code = application_sender_code
      @application_receiver_code = application_receiver_code
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
        :functional_group_header,
        functional_identifier_code: @functional_identifier_code,
        application_sender_code: @application_sender_code,
        application_receiver_code: @application_receiver_code,
        date: @date_time.ccyymmdd,
        time: @date_time.hhmm,
        group_control_number: @group_control_number,
        responsible_agency_code: :accredited_standards_committee_x12,
        version_code: Codes::VERSION_CODE
      )
    end

    def trailer
      Segment.new(
        :functional_group_trailer,
        transaction_set_count: @transaction_sets.length,
        group_control_number: @group_control_number
      )
    end

    attr_accessor :group_control_number, :application_sender_code, :application_receiver_code,
      :date_time, :functional_identifier_code, :transaction_sets
  end
end
