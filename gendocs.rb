require_relative "lib/rbedi.rb"

segments_list_heading = <<EOF
# Segments
EOF

def segments_docs_path
  "docs/segments.md"
end

def segment_docs_path(segment_code)
  "segments/#{segment_code}.md"
end

def element_codes_path(segment_code, element_position)
  "elements/#{segment_code}_#{element_position}.md"
end

def segment_list_item(segment_code, segment_symbol)
<<EOF
* [`#{segment_code}` - `:#{segment_symbol}`](#{segment_docs_path(segment_code)})
EOF
end

def elements_list_heading(segment_code, segment_symbol)
<<EOF
# Elements for #{segment_code} - #{segment_symbol}
EOF
end

def element_list_item(element_position, element_symbol)
<<EOF
* [#{element_position}: `:#{element_symbol}`](#{element_codes_path(segment_code, element_position)})
EOF
end

File.write(segments_docs_path, segments_list_heading)

RBEDI::Codes::SEGMENT_NAMES.each do |segment_code, segment_symbol|
  File.write(segments_docs_path, segment_list_item(segment_code, segment_symbol), mode: ?a)

  codes_class = RBEDI::Codes.const_get(segment_code)
  codes_class::SEGMENT_POSITIONS.each do |element_position, element_symbol|
    File.write("docs/")
  end
end
