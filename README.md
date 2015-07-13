[![Build Status](https://travis-ci.org/rosette-proj/rosette-serializer-xml.svg)](https://travis-ci.org/rosette-proj/rosette-serializer-xml) [![Code Climate](https://codeclimate.com/github/rosette-proj/rosette-serializer-xml/badges/gpa.svg)](https://codeclimate.com/github/rosette-proj/rosette-serializer-xml) [![Test Coverage](https://codeclimate.com/github/rosette-proj/rosette-serializer-xml/badges/coverage.svg)](https://codeclimate.com/github/rosette-proj/rosette-serializer-xml/coverage)

rosette-serializer-xml
====================

Provides a way of writing XML files from lists of translations for the Rosette internationalization platform.

## Installation

`gem install rosette-serializer-xml`

Then, somewhere in your project:

```ruby
require 'rosette/serializers/xml-serializer'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform. rosette-serializer-xml is capable of writing translations in XML file format, specifically those that use the structure of one of the following:

1. Strings, string arrays, and plurals for Android projects (see: [http://developer.android.com/guide/topics/resources/string-resource.html](http://developer.android.com/guide/topics/resources/string-resource.html)).

Additional types of XML structure are straightforward to support. Open an issue or pull request if you'd like to see support for another structure.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding Android string serialization support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/serializer/xml-serializer'

rosette_config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo.add_serializer('xml', format: 'xml/android')
  end
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

Serializers support a set of configuration options, including adding pre-processors. Preprocessors are applied before translations are serialized. Adding the [normalization pre-processor](https://github.com/rosette-proj/rosette-preprocessor-normalization), for example, looks like this:

```ruby
repo.add_serializer('xml', format: 'xml/android') do |serializer_config|
  serializer_config.add_preprocessor('normalization') do |pre_config|
    pre_config.set_normalization_form(:nfc)
  end
end
```

### Standalone Usage

While most of the time rosette-serializer-xml will probably be used alongside rosette-server (or similar), there may arise use cases where someone might want to use it on its own. The `write_key_value` method on `AndroidSerializer` writes a key/value pair to the underlying stream:

```ruby
stream = StringIO.new
locale = Rosette::Core::Locale.parse('pt-BR')
serializer = Rosette::Serializer::XmlSerializer::AndroidSerializer.new(stream, locale)

serializer.write_key_value('foo', 'bar')
serializer.flush

# <?xml version="1.0" encoding="UTF-8" ?>
# <resources>
#   <string name="foo">bar</string>
# </resources>
stream.string
```

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
