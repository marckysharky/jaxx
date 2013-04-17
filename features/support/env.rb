require 'rubygems'
require 'bundler/setup'

$:.unshift File.expand_path('../../../bin', __FILE__)
$:.unshift File.expand_path('../../../lib', __FILE__)

require 'jaxx'
require 'cucumber'
require 'aruba'
require 'aruba/cucumber'
require 'rspec'
require 'rspec/core'
require 'cucumber/rspec/doubles'
require File.expand_path('../../../spec/helpers/service', __FILE__)

World(ServiceHelper)

Before do
  @aruba_timeout_seconds = 10
end
