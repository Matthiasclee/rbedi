module RBEDI
  class Segment
    def initialize(segment_name, segment_elements)
      @segment_name = segment_name

      begin
        @codes_class = Codes.const_get(@segment_name)
      rescue NameError
        @codes_class = nil
      end

      @segment_elements = segment_elements
    end

    def to_s
      @segment_elements.insert(0, @segment_name).join(Codes::ELEMENT_SEPARATOR) + Codes::SEGMENT_TERMINATOR
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
      code = @codes_class.code(element, value)

      set_raw_element(element, code.nil? ? value : code)
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

    attr_reader :segment_name, :segment_elements

    private
    
    def get_element_pos(element)
      return @codes_class::SEGMENT_POSITIONS.key(element) unless element.is_a?(Integer)
      return element
    end
  end
end
