module Fog
  module Network
    class OpenStack
      class Real
        def get_vpc(vpc_id)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "vpcs/#{vpc_id}"
          )
        end
      end

      class Mock
        #TODO Not support
        def get_vpc(vpc_id)
          raise Fog::OpenStack::Errors::InterfaceNotImplemented.new('Method :get_vpc is not implemented')
        end
      end
    end
  end
end
