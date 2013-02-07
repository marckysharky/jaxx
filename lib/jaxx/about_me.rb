require 'jaxx/environment'
require 'jaxx/api_mapper'

module Jaxx
  class AboutMe
    extend ApiMapper

    host "169.254.169.254"
    base_path "/latest/meta-data"

    attribute_via_path :ami_id
    attribute_via_path :ami_launch_index
    attribute_via_path :ami_manifest_path
    attribute_via_path :hostname
    attribute_via_path :instance_action
    attribute_via_path :instance_id
    attribute_via_path :instance_type
    attribute_via_path :kernel_id
    attribute_via_path :local_hostname
    attribute_via_path :local_ipv4
    attribute_via_path :mac
    attribute_via_path :profile
    attribute_via_path :public_hostname
    attribute_via_path :public_ipv4
    attribute_via_path :reservation_id
    attribute_via_path :security_groups
    attribute_via_path :az, 'placement/availability-zone'

    def to_hash
      self.class.api_attributes.inject({}) {|hsh, at| hsh[at] = send(at); hsh }
    end

    def inspect
      self.to_hash.to_s
    end

  end
end
