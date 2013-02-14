require 'spec_helper'

module Jaxx
  describe Upload do

    describe "#process" do
      let(:args) { ({ 'access_key' => 'foo', 'access_secret' => 'bar', 'file' => File.expand_path('bar.txt', __FILE__), 'bucket' => 'temp' }) }

      subject { described_class.new(args) }

      before :each do
        Fog.mock!
      end

      it "sends file to storage" do
        File.stub(:exist?).with(args['file']).and_return(true)
        File.should_receive(:read).with(args['file']).and_return("")
        File.should_receive(:basename).with(args['file']).and_return('bar.txt')

        subject.execute
      end

      it "defaults filename to original filename" do
        subject.filename.should eq('bar.txt')
      end

      it "allows assignment of filename" do
        args['filename'] = 'foo.txt'
        subject.filename.should eq('foo.txt')
      end
    end

  end
end
