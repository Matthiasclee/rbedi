module RBEDI
  class TransactionEnvelope
    def initialize(
      interchange_sender_id_qualifier: :mutually_defined,
      interchange_sender_id:,
      interchange_receiver_id_qualifier: :mutually_defined,
      interchange_receiver_id:,
      functional_groups: [],
      interchange_control_number:,
      date_time: DateTime.now,
      repetition_separator: ?^,
      component_element_separator: ?:,
      interchange_usage_indicator: :production,
      authorization_information_qualifier: :no_authorization_information_present,
      authorization_information: " " * 10,
      security_information_qualifier: :no_security_information_present,
      security_information: " " * 10,
      acknowledgement_requested: false
    )
      @interchange_sender_id = interchange_sender_id
      @interchange_receiver_id = interchange_receiver_id
      @interchange_sender_id_qualifier = interchange_sender_id_qualifier
      @interchange_receiver_id_qualifier = interchange_receiver_id_qualifier
      @authorization_information_qualifier = authorization_information_qualifier
      @authorization_information = authorization_information
      @security_information_qualifier = security_information_qualifier
      @security_information = security_information
      @repetition_separator = repetition_separator
      @component_element_separator = component_element_separator
      @interchange_control_number = "%09d" % interchange_control_number
      @acknowledgement_requested = acknowledgement_requested
      @date_time = EDIDateTime.new(date_time)
      @functional_groups = functional_groups
      @interchange_usage_indicator = interchange_usage_indicator
    end

    def to_s
      header.to_s +
        @functional_groups.map(&:to_s).join +
        trailer.to_s
    end

    def header
      Segment.new(
        :interchange_control_header,
        authorization_information_qualifier: @authorization_information_qualifier,
        authorization_information: @authorization_information,
        security_information_qualifier: @security_information,
        security_information: @security_information,
        interchange_sender_id_qualifier: @interchange_sender_id_qualifier,
        interchange_receiver_id_qualifier: @interchange_receiver_id_qualifier,
        interchange_sender_id: @interchange_sender_id.ljust(15),
        interchange_receiver_id: @interchange_receiver_id.ljust(15),
        interchange_date: @date_time.yymmdd,
        interchange_time: @date_time.hhmm,
        repetition_separator: @repetition_separator,
        interchange_control_version_number: Codes::INTERCHANGE_CONTROL_VERSION_NUMBER,
        interchange_control_number: @interchange_control_number,
        acknowledgement_requested: @acknowledgement_requested,
        interchange_usage_indicator: @interchange_usage_indicator,
        component_element_separator: @component_element_separator
      )
    end

    def trailer
      Segment.new(
        :interchange_control_trailer,
        @functional_groups.length,
        @interchange_control_number
      )
    end

    attr_accessor :interchange_sender_id, :interchange_sender_id_qualifier, :interchange_receiver_id, :interchange_receiver_id_qualifier,
      :repetition_separator, :component_element_separator, :date_time, :interchange_control_number, :acknowledgement_requested, :authorization_information_qualifier,
      :authorization_information, :security_information_qualifier, :security_information, :functional_groups, :interchange_usage_indicator
  end
end
