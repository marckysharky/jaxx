require 'fog'

module Jaxx
  
  class Transaction

    PRIVACIES = %w[public private]
    
    attr_reader :bucket, :access_key, :access_secret, :file, :privacy

    def initialize args = {}
      @bucket, @access_key, @access_secret, @file, @privacy = args.values_at 'bucket', 'access_key', 'access_secret', 'file', 'privacy'
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
      if Jaxx.environment.ami? and (key.empty? or secret.empty?)
        creds  = Jaxx.environment.credentials
        key    ||= creds[:access_key]
        secret ||= creds[:access_secret]
      end
      @credentials = { access_key: key, access_secret: secret }
    end

    def process
      errs = errors
      if errs.empty?
        remote_directory.files.create(:key => File.basename(file), :body => File.read(file), :public => public?)
      else
        raise RuntimeError, "Unable to process transaction: #{errs.inspect}"
      end
    end

    def validate
      err = {} 
      err[:bucket]      = "is required" unless validate_bucket
      err[:file]        = "given cannot be processed"  unless validate_file
      err[:credentials] = "for access key and access secret required" unless validate_credentials
      err[:privacy]     = "#{privacy} is not supported" unless validate_privacy
      err
    end

    alias :errors :validate

    private

    def remote_directory
      s3  = Fog::Storage::AWS.new :aws_access_key_id => credentials[:access_key], :aws_secret_access_key => credentials[:access_secret], :use_iam_profile => Jaxx.environment.ami?
      dir = s3.directories.get(bucket)
      dir ||= s3.directories.create(:key => bucket, :public => public?)
      dir
    end

    def validate_bucket
      !bucket.to_s.empty?
    end

    def validate_file
      !file.to_s.empty? and File.exist?(file.to_s)
    end

    def validate_credentials
      !credentials[:access_key].empty? and !credentials[:access_secret].empty?
    end

    def validate_privacy
      PRIVACIES.include?(privacy.to_s)
    end

  end
end
