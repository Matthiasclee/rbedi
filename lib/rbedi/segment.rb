module RBEDI
  class Segment
    include Codes

    def initialize(segment_name, segment_elements)
      @segment_name = segment_name
      @segment_elements = segment_elements
    end

    def to_s
      @segment_elements.insert(0, @segment_name).join(ELEMENT_SEPARATOR) + SEGMENT_TERMINATOR
    end

    def [](n)
      @segment_elements[n]
    end

    def self.parse(segment)
      elements = segment.split(ELEMENT_SEPARATOR)
      new(elements[0], elements[1..-1])
    end

    attr_reader :segment_name, :segment_elements
  end
end
