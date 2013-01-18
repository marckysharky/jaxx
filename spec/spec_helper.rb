require 'rubygems'
require 'bundler/setup'
require 'fakeweb'
$:.unshift File.expand_path('../lib', __FILE__)
require 'jaxx'

require_relative 'helpers/service'

RSpec.configure do |c|
  c.include ServiceHelper 
end
