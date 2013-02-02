require 'spec_helper'

module Jaxx
  describe Environment do

    it "#service_timeout" do
      subject.service_timeout.should_not be_nil
    end

    context "outside ami instance" do
      
      it "#credentials" do
        subject.credentials.should be_kind_of(Hash)
        subject.credentials[:aws_session_token].should be_nil
      end
    end

    context "within ami instance" do

      it "#credentials" do
        stub_credentials_service
        subject.credentials.should be_kind_of(Hash)
      end
    end
  end
end
