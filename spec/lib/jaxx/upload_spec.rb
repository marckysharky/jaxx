require 'spec_helper'

module Jaxx
  describe Upload do

    describe "#process" do
      let(:args) { ({ 'access_key' => 'foo', 'access_secret' => 'bar', 'file' => File.expand_path('bar.txt', __FILE__), 'bucket' => 'temp' }) }

      subject { described_class.new(args) }

      it "sends file to storage" do
        Fog.mock!
         
        File.stub(:exist?).with(args['file']).and_return(true)
        File.should_receive(:read).with(args['file']).and_return("")
        File.should_receive(:basename).with(args['file']).and_return('bar.txt')

        subject.execute
      end
    end

  end
end
