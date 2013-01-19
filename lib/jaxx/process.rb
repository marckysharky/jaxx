require 'fog'

module Jaxx
  class Process

    PRIVACIES = %w[public private]
    
    attr_reader :bucket, :access_key, :access_secret, :file, :privacy, :validations

    def initialize args = {}
      @bucket, @access_key, @access_secret, @file, @privacy = args.values_at 'bucket', 'access_key', 'access_secret', 'file', 'privacy', 'validations'
      @validations = [:bucket, :credentials, :file_presence] + (args['validations'] || [])
    end

    def privacy
      @privacy || 'private'
    end

    def private?
      privacy.to_s == 'private'
    end

    def public?
      !private?
    end

    def credentials
      return @credentials unless @credentials.nil?

      key, secret = access_key.to_s, access_secret.to_s
      if (key.empty? or secret.empty?) and Jaxx.environment.ami?
        key, secret = Jaxx.environment.credentials.values_at :access_key, :access_secret
      end
      @credentials = { access_key: key, access_secret: secret }
    end

    def start &block
      errs = errors
      
      ["Unable to process transaction", format_errors(errs)].flatten.each do |msg|
        Jaxx.logger.write msg
      end and raise(RuntimeError) unless errs.empty?

      block.call(storage)
    end

    def validate
      validations.inject({}) do |hsh, name|
        validation = send("validate_#{name}")
        hsh[name] = validation unless validation.nil?
        hsh
      end
    end

    alias :errors :validate

    private

    def storage
      @storage ||= Fog::Storage::AWS.new :aws_access_key_id => credentials[:access_key], 
        :aws_secret_access_key => credentials[:access_secret], 
        :use_iam_profile       => Jaxx.environment.ami?
    end

    def validate_bucket
      "is required" if bucket.to_s.empty?
    end

    def validate_file_presence
      "is required" if file.to_s.empty?
    end

    def validate_file_exists
      "returned false" unless File.exist?(file.to_s)
    end

    def validate_credentials
      "for access key and access secret required" if credentials[:access_key].empty? or credentials[:access_secret].empty?
    end

    def validate_privacy
      "#{privacy} is not supported" unless PRIVACIES.include?(privacy.to_s)
    end

    def format_errors(errs)
      errs.collect {|name, msg| [name.to_s.gsub(/_/, ' '), msg].join(' ') }
    end
  end
end
