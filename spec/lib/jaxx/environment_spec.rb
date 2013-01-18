require 'spec_helper'

module Jaxx
  describe Environment do

    it "#service_domain" do
      subject.service_domain.should_not be_nil
    end

    it "#service_path" do
      subject.service_path.should_not be_nil
    end

    it "#service_timeout" do
      subject.service_timeout.should_not be_nil
    end

    context "outside ami instance" do
      
      it "#ami?" do
        subject.ami?.should be_false
      end

      it "#credentials" do
        subject.credentials.should be_nil
      end
    end

    context "within ami instance" do

      before :each do
        stub_credentials_service
      end
      
      it "#ami?" do
        subject.ami?.should be_true
      end

      it "#credentials" do
        subject.credentials.should be_kind_of(Hash)
      end
    end
  end
end
