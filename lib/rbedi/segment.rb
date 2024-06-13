module RBEDI
  class Segment
    def initialize(segment_name, segment_elements)
      @segment_name = get_raw_segment_name(segment_name)

      begin
        @codes_class = Codes.const_get(@segment_name)
      rescue NameError
        @codes_class = nil
      end

      if segment_elements.is_a?(Hash)
        @segment_elements = []
        segment_elements.each do |k, v|
          self[k] = v
        end
      else
        @segment_elements = segment_elements
      end
    end

    def to_s
      ([@segment_name] + @segment_elements).join(Codes::ELEMENT_SEPARATOR) + Codes::SEGMENT_TERMINATOR
    end

    def [](element)
      return get_raw_element(element) unless @codes_class

      element = get_element_pos(element)
      code = @codes_class.code(element, get_raw_element(element))
      code.nil? ? get_raw_element(element) : code
    end

    def []=(element, value)
      return set_raw_element(element, value) unless @codes_class

      element = get_element_pos(element)

      return set_raw_element(element, value) if value.is_a?(String)

      code = @codes_class.code(element, value)

      set_raw_element(element, code.nil? ? value : code)
    end

    def segment_type
      Codes::SegmentNames.segment_name(raw_segment_name)
    end

    def raw_segment_name
      @segment_name
    end

    def get_raw_element(n)
      @segment_elements[n - 1]
    end

    def set_raw_element(n, v)
      @segment_elements[n - 1] = v
    end

    def self.parse(segment)
      elements = segment.split(Codes::ELEMENT_SEPARATOR)
      new(elements[0], elements[1..-1])
    end

    attr_reader :segment_elements

    private
    
    def get_element_pos(element)
      return @codes_class::SEGMENT_POSITIONS.key(element) unless element.is_a?(Integer)
      return element
    end

    def get_raw_segment_name(name)
      return Codes::SegmentNames.segment_name(name) unless name.is_a?(String)
      return name
    end
  end
end
