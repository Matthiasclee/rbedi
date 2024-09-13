require_relative "lib/rbedi.rb"

Gem::Specification.new do |rbedi|
  rbedi.name        = 'rbedi'
  rbedi.version     = RBEDI.version
  rbedi.summary     = "Interface to interact with X12 EDI files"
  rbedi.description = "RBEDI provides an easy API to create, read, and edit X12 EDI files. Currently, only X12 5010 HIPAA 270/271 transaction sets are completely implemented."
  rbedi.authors     = ["Matthias Lee"]
  rbedi.email       = 'matthias@matthiasclee.com'
  rbedi.files       = RBEDI.file_paths + RBEDI.executables.map{|i|"bin/#{i}"}
  rbedi.executables = RBEDI.executables
  rbedi.add_runtime_dependency "argparse", "~> 0.0.5"
  rbedi.add_runtime_dependency "rbtext", "~> 0.3.5"
  rbedi.require_paths = ['lib']
  
  rbedi.homepage = 'https://matthiasclee.github.io/rbedi/'
  rbedi.license = 'CC-BY-NC-SA-4.0'
end
