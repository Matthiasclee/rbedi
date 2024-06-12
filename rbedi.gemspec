require_relative "lib/rbedi.rb"

Gem::Specification.new do |rbedi|
  rbedi.name        = 'rbedi'
  rbedi.version     = RBEDI.version
  rbedi.summary     = "Interface to interact with X12 EDI files"
  rbedi.description = "Interface to interact with X12 EDI files"
  rbedi.authors     = ["Matthias Lee"]
  rbedi.email       = 'matthias@matthiasclee.com'
  rbedi.files       = RBEDI.file_paths + RBEDI.executables.map{|i|"bin/#{i}"}
  rbedi.executables = RBEDI.executables
  rbedi.require_paths = ['lib']
  
  rbedi.homepage = 'https://github.com/Matthiasclee/rbedi'
  rbedi.license = 'CC-BY-NC-SA-4.0'
end
