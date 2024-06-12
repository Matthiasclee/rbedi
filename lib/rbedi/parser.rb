module RBEDI
  class Parser
    include Codes

    def initialize(edi_data, fragment: false)
      @edi_data = edi_data
      @fragment = fragment
    end

    def parse
      segments = to_segments
      return segments if @fragment

      generate_transaction(segments)
    end

    private

    def generate_transaction(segments)
      transaction_envelope = nil
      current_functional_group = nil
      current_transaction_set = nil

      segments.each do |segment|
        if segment.segment_name == INTERCHANGE_CONTROL_HEADER_SEGMENT_NAME
          transaction_envelope = generate_transaction_envelope(segment)
          next
        end

        break if segment.segment_name == INTERCHANGE_CONTROL_HEADER_SEGMENT_NAME

        if segment.segment_name == FUNCTIONAL_GROUP_HEADER_SEGMENT_NAME
          current_functional_group = generate_functional_group(segment)
          next
        end

        if segment.segment_name == FUNCTIONAL_GROUP_TRAILER_SEGMENT_NAME
          transaction_envelope.functional_groups << current_functional_group
          current_functional_group = nil
          next
        end

        if segment.segment_name == TRANSACTION_SET_HEADER_SEGMENT_NAME
          current_transaction_set = generate_transaction_set(segment)
          next
        end

        if segment.segment_name == TRANSACTION_SET_TRAILER_SEGMENT_NAME
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
        transaction_set_control_number: segment[1].to_i,
        transaction_set_identifier: segment[0]
      )
    end

    def generate_functional_group(segment)
      FunctionalGroup.new(
        group_control_number: segment[5].to_i,
        functional_identifier_code: segment[0],
        submitter_id: segment[1].strip,
        receiver_id: segment[2].strip,
        date_time: EDIDateTime.parse(date: segment[3], time: segment[4]).datetime_start
      )
    end

    def generate_transaction_envelope(segment)
      TransactionEnvelope.new(
        submitter_id: segment[5].strip,
        receiver_id: segment[7].strip,
        date_time: EDIDateTime.parse(date: segment[8], time: segment[9]).datetime_start,
        repetition_separator: segment[10],
        component_separator: segment[15],
        acknowledgement_requested: segment[13] == ?1,
        usage_indicator: segment[14],
        interchange_control_number: segment[12].to_i
      )
    end

    def to_segments
      segments = @edi_data.split(SEGMENT_TERMINATOR)
      segments.map { |segment| Segment.parse(segment) }
    end
  end
end
