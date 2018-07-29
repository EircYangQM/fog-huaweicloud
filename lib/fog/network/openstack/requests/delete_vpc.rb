module Fog
  module Network
    class OpenStack
      class Real
        def delete_vpc(vpc_id)
          if @openstack_version == "v1"
            request(
                :expects => 204,
                :method  => 'DELETE',
                :path    => "vpcs/#{vpc_id}"
            )
          else
           #TODO Not support
          end
        end
      end

      class Mock
        def delete_vpc(subnet_id, vpc_id)
          raise Fog::OpenStack::Errors::InterfaceNotImplemented.new('Method :delete_vpc is not implemented')
        end
      end
    end
  end
end
