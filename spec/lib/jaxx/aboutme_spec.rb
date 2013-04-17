require 'spec_helper'
require 'json'

module Jaxx
  describe AboutMe do

    it "#ami_id" do
      ensure_api_response :ami_id, "ami-123"
    end

    it "#ami_launch_index" do
      ensure_api_response :ami_id, "0"
    end

    it "#ami-manifest-path" do
      ensure_api_response :ami_id, "manifest.xml"
    end

    it "#block-device-mapping"

    it "#hostname" do
      ensure_api_response :hostname, "ip-123-123"
    end

    it "#instance_action" do
      ensure_api_response :instance_action, "none"
    end

    it "#instance_id" do
      ensure_api_response :instance_id, "123"
    end

    it "#instance_type" do
      ensure_api_response :instance_type, "m1.small"
    end

    it "#kernel_id" do
      ensure_api_response :kernel_id, "aki-123"
    end

    it "#local_hostname" do
      ensure_api_response :local_hostname, "ip-123"
    end

    it "#local_ipv4" do
      ensure_api_response :local_ipv4, "127.0.0.1"
    end

    it "#mac" do
      ensure_api_response :mac, "123-456-78"
    end

    it "#metrics"

    it "#network"

    it "#placement" do
      ensure_api_response :az, "us-east-1", "placement/availability-zone"
    end

    it "#profile" do
      ensure_api_response :profile, "default"
    end

    it "#public_hostname" do
      ensure_api_response :public_hostname, "ec2-1223.com"
    end

    it "#public_ipv4" do
      ensure_api_response :public_ipv4, "52.51.52.51"
    end

    it "#public_keys"

    it "#reservation_id" do
      ensure_api_response :reservation_id, "r-123"
    end

    it "#security_groups" do
      ensure_api_response :security_groups, "default"
    end

    it "#to_hash" do
      stub_meta_request /#{described_class.host}/, ""
      hsh = subject.to_hash

      hsh.should be_kind_of(Hash)
      hsh.keys.sort{|a,b| a.to_s <=> b.to_s }.should == subject.class.api_attributes.sort{|a,b| a.to_s <=> b.to_s }
    end
  end
end
