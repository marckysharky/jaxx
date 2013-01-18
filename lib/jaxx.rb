require "jaxx/version"
require "jaxx/transaction"
require "jaxx/environment"

module Jaxx

  def self.save args = {}
    Jaxx::Transaction.new(args).process
  end

  def self.environment
    @environment ||= Environment.new
  end
end
