require 'optparse'
require 'jaxx'

module Jaxx
  module CLI

    def self.execute meth, args
      parser.parse!(args)
      options.empty? ? (STDOUT.write(parser) and exit) : Jaxx.send(meth, options)
    rescue RuntimeError => exc
      exit 1
    end

    def self.parser 
      OptionParser.new do |o|
        o.banner = "jaxx [options]"

        o.on('-b', '--bucket [BUCKET]')                 { |b| options['bucket'] = b }
        o.on('-k', '--access-key [ACCESS_KEY]')         { |k| options['access_key'] = k }
        o.on('-s', '--access-secret [ACCESS_SECRET]')   { |s| options['access_secret'] = s }
        o.on('-f', '--file [FILE]')                     { |f| options['file'] = f }
        o.on('-p', '--privacy [PRIVACY]')               { |p| options['privacy'] = p }
        o.on('-h', '--help')                            { o }
      end
    end

    def self.options
      @options ||= {}
    end

  end
end
