require 'spec_helper'
require 'fog/aws/models/storage/directories'

module Jaxx
  describe Upload do

    describe "#process" do
      let(:args) { ({ 
        'access_key'    => 'foo', 
        'access_secret' => 'bar', 
        'file'          => File.expand_path('../bar.txt', __FILE__), 
        'bucket'        => 'temp',
        'retries'       => 1
      }) }

      subject { described_class.new(args) }

      it "defaults filename to original filename" do
        subject.filename.should eq('bar.txt')
      end

      it "allows assignment of filename" do
        args['filename'] = 'foo.txt'
        subject.filename.should eq('foo.txt')
      end

      describe "sending files" do
        let(:files) { double('files', :merge_attributes => {}, :load => {}) }

        before :each do 
          Fog.mock!
          File.stub(:exist?).with(args['file']).and_return(true)
          File.stub(:basename).with(args['file']).and_return('bar.txt')
          Fog::Storage::AWS::Directory.any_instance.stub(:files).and_return(files)
          File.stub(:read).with(args['file']).any_number_of_times.and_return("")
        end

        it "to storage" do
          files.should_receive(:create).and_return(true)

          subject.execute
        end
        
        it "with retries" do
          files.should_receive(:create).exactly(subject.retries).times.and_return(false)

          Proc.new { subject.execute }.should raise_error(RuntimeError)
        end

        it "with failed create" do
          files.should_receive(:create).exactly(subject.retries).times.and_raise(RuntimeError)

          Proc.new { subject.execute }.should raise_error(RuntimeError)
        end

      end
    end
  end
end
