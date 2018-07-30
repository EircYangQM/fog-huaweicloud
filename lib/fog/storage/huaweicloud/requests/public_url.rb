module Fog
  module Storage
    class HuaweiCloud
      module PublicUrl
        # Get public_url for an object
        #
        # ==== Parameters
        # * container<~String> - Name of container to look in
        # * object<~String> - Name of object to look for
        #
        def public_url(container = nil, object = nil)
          return nil if container.nil?
          u = "#{url}/#{Fog::HuaweiCloud.escape(container)}"
          u << "/#{Fog::HuaweiCloud.escape(object)}" unless object.nil?
          u
        end

        private

        def url
          "#{@scheme}://#{@host}:#{@port}#{@path}"
        end
      end

      class Real
        include PublicUrl
      end

      class Mock
        include PublicUrl
      end
    end
  end
end
