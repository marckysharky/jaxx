require 'spec_helper'
require 'fog/aws/models/storage/directory'

module Jaxx
  describe Transaction do

    it "raises RuntimeError on invalid process" do
      -> { described_class.new.process }.should raise_error(RuntimeError)
    end

    it "accepts bucket" do
      described_class.new('bucket' => 'foo').bucket.should == 'foo'
    end

    it "raises error on missing bucket" do
      described_class.new.errors.should include(:bucket => 'is required')
    end

    it "raises error on local authentication, when not on AMI"

    it "accepts access key" do
      described_class.new('access_key' => 'abc').access_key.should == 'abc'
    end

    it "accepts access secret" do
      described_class.new('access_secret' => 'abc').access_secret.should == 'abc'
    end

    it "accepts file" do
      file = double 'file'
      described_class.new('file' => file).file.should == file
    end

    context "passing a file path" do
      
      it "raises error on missing file" do
        described_class.new.errors.should include(:file => "given cannot be processed")
      end

      it "includes error when file does not exist" do
        file = "foo"
        described_class.new('file' => file).errors.should include(:file => "given cannot be processed")
      end

      it "includes error when path is empty" do
        described_class.new('file' => "").errors.should include(:file => "given cannot be processed")
      end
    end

    it "accepts privacy level" do
      described_class.new('privacy' => 'private').privacy.should == 'private'
    end

    it "defaults privacy level to private" do
      described_class.new.privacy.should == 'private'
    end

    it "raises error on invalid privacy level" do
      described_class.new('privacy' => 'foo').errors.should include(:privacy => "foo is not supported")
    end

    context "non-ami environment" do

      it "raises error on missing access key" do
        described_class.new.errors.should include(:credentials => "for access key and access secret required")
      end

      it "raises error on missing access secret" do
        described_class.new.errors.should include(:credentials => "for access key and access secret required")
      end
    end

    context "ami environment" do
      
      before :each do
        stub_credentials_service
      end

      it "allows access key to be empty" do
        described_class.new.errors.should_not include(:access_key)
      end

      it "allows access secret to be empty" do
        described_class.new.errors.should_not include(:access_secret)
      end
    end

    describe "#process" do
      let(:args) { ({ 'access_key' => 'foo', 'access_secret' => 'bar', 'file' => File.expand_path('bar.txt', __FILE__), 'bucket' => 'temp' }) }
      
      subject { described_class.new(args) }
      
      it "sends file to storage" do
        Fog.mock!
         
        File.stub(:exist?).with(args['file']).and_return(true)
        File.should_receive(:read).with(args['file']).and_return("")
        File.should_receive(:basename).with(args['file']).and_return('bar.txt')

        subject.process
      end
    end
  end
end
