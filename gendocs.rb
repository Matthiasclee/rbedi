require_relative "lib/rbedi.rb"

segments_list_heading = <<EOF
# Segments
EOF

def segments_docs_path
  "docs/segments.md"
end

def segment_docs_path(segment_code, relative=true)
  relative ? "segments/#{segment_code}.md" : "docs/segments/#{segment_code}.md"
end

def element_codes_path(segment_code, element_position, relative=true)
  relative ? "../elements/#{segment_code}_#{element_position}.md" : "docs/elements/#{segment_code}_#{element_position}.md"
end

def segment_list_item(segment_code, segment_symbol)
<<EOF
* `#{segment_code}` - [`:#{segment_symbol}`](#{segment_docs_path(segment_code)})
EOF
end

def segment_elements_list_heading(segment_code, segment_symbol)
<<EOF
# Elements for #{segment_code} - #{segment_symbol}
EOF
end

def segment_element_list_item(element_position, element_symbol, segment_code, codes_count)
  unless codes_count.nil?
<<EOF
* #{element_position}: `:#{element_symbol}` - [#{codes_count} codes](#{element_codes_path(segment_code, element_position)})
EOF
  else
<<EOF
* #{element_position}: `:#{element_symbol}` - no codes
EOF
  end
end

def element_codes_list_heading(segment_code, element_position, element_symbol)
<<EOF
# Codes for #{segment_code}_#{element_position} - #{element_symbol}
EOF
end

def element_codes_list_item(code, symbol)
<<EOF
* `#{code.upcase}` - `#{symbol.is_a?(Symbol) ? ":#{symbol}" : symbol}`
EOF
end

File.write(segments_docs_path, segments_list_heading)

RBEDI::Codes::SegmentNames::SEGMENT_NAMES.each do |segment_code, segment_symbol|
  File.write(segments_docs_path, segment_list_item(segment_code, segment_symbol), mode: ?a)
  File.write(segment_docs_path(segment_code, false), segment_elements_list_heading(segment_code, segment_symbol))

  codes_class = RBEDI::Codes.const_get(segment_code)
  codes_class::SEGMENT_POSITIONS.each do |element_position, element_symbol|
    codes_hash = codes_class::CODES[element_position]

    unless codes_hash.nil?
      File.write(segment_docs_path(segment_code, false), segment_element_list_item(element_position, element_symbol, segment_code, codes_hash.length), mode: ?a)
      File.write(element_codes_path(segment_code, element_position, false), element_codes_list_heading(segment_code, element_position, element_symbol))
      codes_hash.each do |code, symbol|
        File.write(element_codes_path(segment_code, element_position, false), element_codes_list_item(code, symbol), mode: ?a)
      end
    else
      File.write(segment_docs_path(segment_code, false), segment_element_list_item(element_position, element_symbol, segment_code, nil), mode: ?a)
    end
  end
end
