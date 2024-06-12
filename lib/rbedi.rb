module RBEDI
  @@files = [] # All gem files
  @@exe = [] # All executables

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


RBEDI.file_paths(relative:true).each do |f|
  require_relative f
end

