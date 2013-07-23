require 'spec_helper'
require 'fog/aws/models/storage/directories'

module Jaxx
  describe Download do

    describe "#process" do
      let(:args) { ({ 
        'access_key' => 'foo', 
        'access_secret' => 'bar', 
        'file' => File.expand_path('bar.txt', __FILE__), 
        'bucket' => 'temp' 
      }) }

      subject { described_class.new(args) }

      it "sends file to storage" do
        Fog.mock!
        
        directory = double('directory', :files => double('files'))
        directory.files.should_receive(:get).with(args['file'])
        Fog::Storage::AWS::Directories.any_instance.stub(:get).with(args['bucket']).and_return(directory)

        subject.execute
      end
    end

    describe "#files" do

      it "does not process empty filenames" do
        args['file'] = "foo/"

        file = mock('file', key: "foo/")
        directory = double('directory', :files => [file])

        subject.files(directory).should eq({})
      end
    end

  end
end
