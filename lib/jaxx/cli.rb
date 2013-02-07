require 'optparse'
require 'jaxx'

module Jaxx
  module CLI

    def self.execute meth, args

      case meth
      when :upload, :download
        default_parser.parse!(args)
        (Jaxx.logger.write(default_parser) and exit) if options.empty?
      when :aboutme
        aboutme_parser.parse!(args)
        (Jaxx.logger.write(aboutme_parser) and exit) unless options['display']
      end

      Jaxx.send(meth, options)
    rescue RuntimeError => exc
      Jaxx.logger.write "An error occurred: #{exc.message}\n"
      exit 1
    end

    def self.default_parser 
      OptionParser.new do |o|
        o.banner = "jaxx [options]"

        o.on('-b', '--bucket [BUCKET]')                 { |b| options['bucket'] = b }
        o.on('-k', '--access-key [ACCESS_KEY]')         { |k| options['access_key'] = k }
        o.on('-s', '--access-secret [ACCESS_SECRET]')   { |s| options['access_secret'] = s }
        o.on('-f', '--file [FILE]')                     { |f| options['file'] = f }
        o.on('-p', '--privacy [privacy]')               { |p| options['privacy'] = p }
        o.on('-h', '--help')                            { o }
      end
    end

    def self.aboutme_parser
      OptionParser.new do |o|
        o.banner = "jaxx-aboutme [options]"
        o.on('-d', '--display')     { |d| options['display'] = d }
        o.on('-h', '--help')        { o }
      end
    end

    def self.options
      @options ||= {}
    end

  end
end
