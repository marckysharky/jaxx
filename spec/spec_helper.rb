require 'rubygems'
require 'bundler/setup'

$:.unshift File.expand_path('../lib', __FILE__)
require 'jaxx'
require 'rspec'

require_relative 'helpers/service'

Jaxx.logger Logger.new('log/test.log')

RSpec.configure do |c|
  c.include ServiceHelper 
  c.after(:each) { FakeWeb.clean_registry }
end
