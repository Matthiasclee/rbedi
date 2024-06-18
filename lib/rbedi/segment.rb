module RBEDI
  class Segment
    def initialize(segment_name, segment_elements={})
      @segment_name = get_raw_segment_name(segment_name)
      @separator = segment_elements.delete(:_separator)

      begin
        @codes_class = Codes.const_get(@segment_name)
      rescue NameError
        @codes_class = nil
      end

      @segment_elements = []
      segment_elements.each do |k, v|
        self[k] = v
      end
    end

    def to_s
      ([@segment_name] + @segment_elements).join(Codes::ELEMENT_SEPARATOR) + Codes::SEGMENT_TERMINATOR
    end

    def [](element)
      return get_raw_element(element) unless @codes_class

      element_pos = get_element_pos(element)

      raise NonExistentElementError, "Element `#{element}' does not exist for segment `#{raw_segment_name}'" unless element_pos

      code = @codes_class.code(element_pos, get_raw_element(element_pos))

      raw_element = get_raw_element(element_pos)

      if @separator
        raw_element = raw_element.split(@separator)
        raw_element.map! do |i|
          c = @codes_class.code(element_pos, i)
          c.nil? ? i : c
        end

        return raw_element unless raw_element.length == 1
      end

      code.nil? ? raw_element : code
    end

    def []=(element, value)
      return set_raw_element(element, (value.is_a?(Array) && @separator) ? value.join(@separator) : value.to_s) unless @codes_class

      element_pos = get_element_pos(element)

      raise NonExistentElementError, "Element `#{element}' does not exist for segment `#{raw_segment_name}'" unless element_pos

      if @separator && value.is_a?(Array)
        value.map! do |i|
          if i.is_a?(String)
            i
          else
            c = @codes_class.code(element_pos, i)
            c.nil? ? i : c
          end
        end

        set_raw_element(element_pos, value.join(@separator))
      else
        return set_raw_element(element_pos, value) if value.is_a?(String)
        code = @codes_class.code(element_pos, value)
        set_raw_element(element_pos, code.nil? ? value : code)
      end
    end

    def segment_type
      Codes::SegmentNames.segment_name(raw_segment_name) || raw_segment_name
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

    def self.parse(segment, separator:nil)
      elements = segment.delete_suffix("~").split(Codes::ELEMENT_SEPARATOR)
      segment = new(elements[0])
      elements[1..-1].each_with_index do |e, i|
        segment.set_raw_element(i+1, e)
      end
      segment.separator = separator
      return segment
    end

    attr_reader :segment_elements
    attr_accessor :separator

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
