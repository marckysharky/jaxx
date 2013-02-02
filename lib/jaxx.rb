require "jaxx/version"
require "jaxx/environment"
require "jaxx/upload"
require "jaxx/download"
require "logger"

module Jaxx

  def self.upload args = {}
    Jaxx::Upload.new(args).execute
  end

  def self.download args = {}
    Jaxx::Download.new(args).execute
  end

  def self.environment
    @environment ||= Environment.new
  end

  def self.logger log = nil
    @logger = log if log
    @logger ||= STDOUT

    [:debug, :deprecation, :warning].each {|d| Fog::Logger[d] = @logger }

    @logger
  end
end
