require 'timeout'

module Jaxx

  module ApiMapper
    
    def self.extended klass
      klass.extend(ClassMethods)
      klass.class_eval { include(InstanceMethods) }
    end

    module ClassMethods

      def api_attributes
        @api_attibutes ||= []
      end

      def attribute_via_path meth, path = nil
        path ||= meth.to_s.gsub('_', '-')
        define_method(meth.to_sym) { make_request path }
        api_attributes.push(meth.to_sym)
      end

      def host h = nil
        @host = h if h
        @host
      end

      def base_path bp = nil
        @base_path = bp if bp
        @base_path
      end

    end

    module InstanceMethods

      private

      def make_request path
        u = URI::HTTP.build :host => self.class.host, :path => full_path_for(path)
        Timeout.timeout(1) do
          Net::HTTP.get u.host, u.path
        end
      end

      def full_path_for partial
        [self.class.base_path, partial].compact.flatten.join('/').gsub('//', '/')
      end

    end

  end
end
