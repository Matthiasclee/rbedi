module RBEDI
  class Parser
    def initialize(edi_data, fragment: false, separator: nil)
      @edi_data = edi_data
      @fragment = fragment
      @separator = separator
    end

    def parse
      segments = to_segments
      return segments.map{|s|Segment.parse(s, separator: @separator)} if @fragment

      generate_transaction(segments)
    end

    private

    def generate_transaction(segments)
      transaction_envelope = nil
      current_functional_group = nil
      current_transaction_set = nil

      segments.each do |segment|
        segment = Segment.parse(segment, separator: @separator)

        if segment.segment_type == :interchange_control_header
          transaction_envelope = generate_transaction_envelope(segment)
          @separator = transaction_envelope.repetition_separator unless @separator
          next
        end

        break if segment.segment_type == :interchange_control_trailer

        if segment.segment_type == :functional_group_header
          current_functional_group = generate_functional_group(segment)
          next
        end

        if segment.segment_type == :functional_group_trailer
          transaction_envelope.functional_groups << current_functional_group
          current_functional_group = nil
          next
        end

        if segment.segment_type == :transaction_set_header
          current_transaction_set = generate_transaction_set(segment)
          next
        end

        if segment.segment_type == :transaction_set_trailer
          current_functional_group.transaction_sets << current_transaction_set
          current_transaction_set = nil
          next
        end

        current_transaction_set&.segments&.push(segment)
      end

      transaction_envelope
    end

    def generate_transaction_set(segment)
      TransactionSet.new(
        transaction_set_control_number: segment[:transaction_set_control_number].to_i,
        transaction_set_identifier_code: segment[:transaction_set_identifier_code]
      )
    end

    def generate_functional_group(segment)
      FunctionalGroup.new(
        group_control_number: segment[:group_control_number].to_i,
        functional_identifier_code: segment[:functional_identifier_code],
        application_sender_code: segment[:application_sender_code].strip,
        application_receiver_code: segment[:application_receiver_code].strip,
        date_time: EDIDateTime.parse(date: segment[:date], time: segment[:time]).datetime_start
      )
    end

    def generate_transaction_envelope(segment)
      TransactionEnvelope.new(
        authorization_information_qualifier: segment[:authorization_information_qualifier],
        authorization_information: segment[:authorization_information],
        security_information_qualifier: segment[:security_information_qualifier],
        security_information: segment[:security_information],
        interchange_sender_id_qualifier: segment[:interchange_sender_id_qualifier],
        interchange_sender_id: segment[:interchange_sender_id],
        interchange_receiver_id_qualifier: segment[:interchange_receiver_id_qualifier],
        interchange_receiver_id: segment[:interchange_receiver_id],
        repetition_separator: segment[:repetition_separator],
        interchange_control_number: segment[:interchange_control_number].to_i,
        acknowledgement_requested: segment[:acknowledgement_requested],
        interchange_usage_indicator: segment[:interchange_usage_indicator],
        component_element_separator: segment[:component_element_separator],
        date_time: EDIDateTime.parse(date: segment[:interchange_date], time: segment[:interchange_time]).datetime_start,
      )
    end

    def to_segments
      segments = @edi_data.split(Codes::SEGMENT_TERMINATOR)
    end
  end
end
