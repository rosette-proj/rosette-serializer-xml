# encoding: UTF-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'expert'
Expert.environment.require_all

require 'rspec'
require 'rosette/core'
require 'rosette/serializers/xml-serializer'
require 'pry-nav'
