module Fog
  module Network
    class HuaweiCloud
      class Real
        def delete_vpc(vpc_id)
          if @huaweicloud_version == "v1"
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
          raise Fog::HuaweiCloud::Errors::InterfaceNotImplemented.new('Method :delete_vpc is not implemented')
        end
      end
    end
  end
end
