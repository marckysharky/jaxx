require 'timeout'
require 'socket'
require 'net/http'
require 'json'

module Jaxx
  class Environment

    DEFAULT_ARGS = {
      'service_domain'  => '169.254.169.254',
      'service_path'    => '/latest/meta-data/iam/security-credentials/default',
      'service_timeout' => 5
    }

    attr_reader :service_domain, :service_path, :service_timeout

    def initialize args = {}
      @service_domain, @service_path, @service_timeout = DEFAULT_ARGS.dup.merge(args).values_at 'service_domain', 'service_path', 'service_timeout'
    end
    
    def ami?
      credentials[:code] == 'Success' 
    end

    def credentials
      return @credentials unless @credentials.nil?
      
      http = Net::HTTP.new service_domain
      http.open_timeout = http.read_timeout = service_timeout
      resp = JSON.parse http.get(service_path).body
      @credentials = { :access_key => resp['AccessKeyId'], :access_secret => resp['SecretAccessKey'], :code => resp['Code'] }
    rescue Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Timeout::Error
      @credentials = { :access_key => nil, :access_secret => nil, :code => 'Failure' }
    end
  end
end
