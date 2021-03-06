$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/serializers/xml/version'

Gem::Specification.new do |s|
  s.name     = 'rosette-serializer-xml'
  s.version  = ::Rosette::XmlSerializerVersion::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron'

  s.description = s.summary = 'A streaming XML serializer for the Rosette internationalization platform.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'htmlentities', '~> 4.3'
  s.add_dependency 'xml-write-stream', '~> 1.0'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", 'Gemfile', 'History.txt', 'README.md', 'Rakefile', 'rosette-serializer-xml.gemspec']
end
