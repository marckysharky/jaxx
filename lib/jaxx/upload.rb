require 'jaxx/process'
require 'mime/types'

module Jaxx
  class Upload

    DEFAULT_RETRIES = 3

    attr_reader :process, :retries

    def initialize args = {}
      @process  = Process.new(args.merge('validations' => [:privacy, :file_exists, :file_presence]))
      @filename = args['filename']
      @retries  = args['retries'] || DEFAULT_RETRIES
    end

    def filename
      @filename || File.basename(process.file)
    end

    def files
      if File.directory?(process.file)
        Dir[File.join(process.file, "**", "*")].reject{|fp| File.directory?(fp) }.inject({}) {|hsh, fp| hsh[fp] = fp.gsub(process.file, ''); hsh }
      else
        { process.file => filename }
      end
    end

    def execute
      process.start do |storage|
        dir, attempts = remote_directory(storage), 0

        files.each do |file, name|
          stat, exc = false, nil
          attempts += 1 

          begin
            stat = create_file dir, file, name
          rescue => ex
            exc = ex
          end

          if !stat and attempts >= self.retries
            raise("File process failed: #{file}:#{name} : #{exc.message rescue nil}") 
          elsif !stat
            redo
          end

          attempts = 0
        end
      end

    end

    private

    def remote_directory storage 
      dir = storage.directories.get(process.bucket)
      dir ||= storage.directories.create(:key => process.bucket, :public => process.public?)
      dir
    end

    def create_file dir, file, name
      dir.files.create(
        :key          => name || file, 
        :body         => File.open(file), 
        :public       => process.public?,
        :content_type => MIME::Types.type_for(file).last
      ) 
    end

  end
end
