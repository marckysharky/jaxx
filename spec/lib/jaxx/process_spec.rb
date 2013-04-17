require 'spec_helper'
require 'fog/aws/models/storage/directory'

module Jaxx
  describe Process do

    it "raises RuntimeError on invalid process" do
      Proc.new { described_class.new.start }.should raise_error(RuntimeError)
    end

    it "accepts bucket" do
      described_class.new('bucket' => 'foo').bucket.should == 'foo'
    end

    it "raises error on missing bucket" do
      described_class.new.errors.should include(:bucket => 'is required')
    end

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
      let(:file) { nil }

      subject { described_class.new('file' => file) }

      it "raises error on missing file" do
        subject.errors.should include(:file_presence => "is required")
      end

      it "includes error when file does not exist" do
        file = "foo"
        subject.errors.should include(:file_presence => "is required")
      end

      it "includes error when path is empty" do
        file = ""
        subject.errors.should include(:file_presence => "is required")
      end
    end

    describe "privacy" do

      it "accepts privacy level" do
        described_class.new('privacy' => 'public', 'validations' => [:privacy]).privacy.should == 'public'
      end

      it "defaults privacy level to private" do
        described_class.new('validations' => [:privacy]).privacy.should == 'private'
      end

      it "raises error on invalid privacy level" do
        described_class.new('privacy' => 'foo', 'validations' => [:privacy]).errors.should include(:privacy => "foo is not supported")
      end

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

  end
end
