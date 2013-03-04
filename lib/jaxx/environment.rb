require 'timeout'
require 'socket'
require 'net/http'
require 'json'
require 'timeout'
require 'fog'

module Jaxx
  class Environment

    DEFAULT_ARGS = { 'service_timeout' => 1 }
    DEFAULT_CREDENTIALS = { :aws_access_key_id => "", :aws_secret_access_key => "", :aws_session_token => nil, :use_iam_profile => false }

    attr_reader :service_timeout

    def initialize args = {}
      @service_timeout = DEFAULT_ARGS.dup.merge(args).delete('service_timeout')
    end

    def credentials
      Timeout::timeout(service_timeout) do 
        DEFAULT_CREDENTIALS.merge Fog::Compute::AWS.fetch_credentials(:use_iam_profile => true)
      end
    rescue Errno::EHOSTDOWN, Errno::EHOSTUNREACH, Timeout::Error => exc
      DEFAULT_CREDENTIALS
    end

  end
end
