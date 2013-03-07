require 'jaxx/process'
require 'mime/types'

module Jaxx
  class Upload

    attr_reader :process

    def initialize args = {}
      @process = Process.new(args.merge('validations' => [:privacy, :file_exists, :file_presence]))
      @filename = args['filename']
    end

    def filename
      @filename || File.basename(process.file)
    end

    def files
      if File.directory?(process.file)
        Dir[File.join(process.file, "**", "*")]
          .reject{|fp| File.directory?(fp) }
          .inject({}) {|hsh, fp| hsh[fp] = fp.gsub(process.file, ''); hsh }
      else
        { process.file => filename }
      end
    end

    def execute
      process.start do |storage|
        directory  = storage.directories.get(process.bucket)
        directory ||= storage.directories.create(:key => process.bucket, :public => process.public?)

        files.each do |file, name|
          raise "File process failed: #{file}:#{name}" unless directory.files.create(
            :key          => name || file, 
            :body         => File.read(file), 
            :public       => process.public?,
            :content_type => MIME::Types.type_for(file).last
          )
        end
      end
    end

  end
end
