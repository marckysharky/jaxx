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
      credentials[:code] == 'Success' 
    end

    def credentials
      return @credentials unless @credentials.nil?
      
      response = credential_response

      @credentials = { 
        :access_key    => response['AccessKeyId'], 
        :access_secret => response['SecretAccessKey'], 
        :code          => response['Code'] 
      }
    rescue Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Timeout::Error => exc
      @credentials = { :access_key => nil, :access_secret => nil, :code => 'Failure' }
    end

    private

    def credential_response
      http = Net::HTTP.new service_domain
      http.open_timeout = http.read_timeout = service_timeout
      JSON.parse http.get(service_path).body
    end
  end
end
