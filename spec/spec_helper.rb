require 'rubygems'
require 'bundler/setup'

$:.unshift File.expand_path('../lib', __FILE__)
require 'jaxx'
require 'rspec'

Jaxx.logger StringIO.new

require_relative 'helpers/service'

RSpec.configure do |c|
  c.include ServiceHelper
  c.after(:each) { FakeWeb.clean_registry }
end
