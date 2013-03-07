require 'jaxx/process'

module Jaxx
  class Download

    attr_reader :process, :filename

    def initialize args = {}
      @process = Process.new(args)
    end

    def files directory
      if process.file.match(%r{/$})
        directory.files.inject({}) do |hsh, f|
          hsh[f.key.gsub(process.file, '')] = f.key if f.key.match(process.file)
          hsh
        end
      else
        { File.basename(process.file) => process.file }
      end
    end

    def execute
      process.start do |storage|
        directory = storage.directories.get(process.bucket)

        files(directory).each do |target, source|
          File.open(target, 'wb') do |file|
            directory.files.get(source) {|chunk, byt_remain, byt_total| file.write(chunk) }
          end
        end
      end
    end

  end
end
