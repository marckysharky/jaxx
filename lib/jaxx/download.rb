require 'jaxx/process'

module Jaxx
  class Download

    attr_reader :process

    def initialize args = {}
      @process = Process.new(args)
    end
  
    def execute
      process.start do |storage|
        directory = storage.directories.get(process.bucket)
        File.open(File.basename(process.file), 'wb') do |file|
          directory.files.get(process.file) do |chunk, byt_remain, byt_total|
            file.write(chunk)
            complete = (((byt_total-byt_remain).to_f/byt_total) * 100)
            Jaxx.logger.info "Saving file: %.2f percent complete.\r" % complete
          end
        end
      end
    end

  end
end
