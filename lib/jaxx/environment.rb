require 'timeout'
require 'socket'
require 'net/http'
require 'json'

module Jaxx
  class Environment

    DEFAULT_ARGS = {
      'service_domain'  => '169.254.169.254',
      'service_path'    => '/latest/meta-data/iam/security-credentials/default',
      'service_timeout' => 1
    }

    attr_reader :service_domain, :service_path, :service_timeout

    def initialize args = {}
      @service_domain, @service_path, @service_timeout = DEFAULT_ARGS.dup.merge(args).values_at 'service_domain', 'service_path', 'service_timeout'
    end
    
    def ami?
      timeout(service_timeout) { TCPSocket.new(service_domain, 'echo').close }
    rescue Errno::ECONNREFUSED
      true
    rescue Timeout::Error, StandardError
      false
    end

    def credentials
      return nil unless ami?
      resp = Net::HTTP.get service_domain, service_path
      JSON.parse(resp)
    end
  end
end
