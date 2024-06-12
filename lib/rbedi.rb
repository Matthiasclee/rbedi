module RBEDI
  @@files = [
    "codes.rb",
    "codes/codeset.rb",
    "edi_date_time.rb",
    "functional_group.rb",
    "parser.rb",
    "segment.rb",
    "transaction_envelope.rb",
    "transaction_set.rb",
  ]
  @@files += Dir.glob("lib/rbedi/codes/*").map {|i| i.delete_prefix("lib/rbedi")}
  @@files.uniq!
  @@exe = []

  def self.version
    "0.0.0"
  end

  def self.executables
    @@exe
  end

  def self.file_paths(relative:false)
    x = @@files.map do |f|
      "#{"lib/" unless relative}rbedi/#{f}"
    end

    if relative
      return x
    else
      return x + ['lib/rbedi.rb']
    end
  end
end

# Additional Requires
require "date"

RBEDI.file_paths(relative:true).each do |f|
  require_relative f
end

