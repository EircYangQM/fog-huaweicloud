module Fog
  module Network
    class HuaweiCloud
      class Real
        def list_vpcs(filters = {})
          request(
            :expects => 200,
            :method  => 'GET',
            :path    => 'vpcs',
            :query   => filters
          )
        end
      end

      class Mock
        def list_vpcs(_filters = {})
          raise Fog::HuaweiCloud::Errors::InterfaceNotImplemented.new('Method :list_vpcs is not implemented')
        end
      end
    end
  end
end
