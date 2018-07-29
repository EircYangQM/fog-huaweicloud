module Fog
  module Network
    class OpenStack
      class Real
        def delete_subnet(subnet_id, vpc_id)
          if @openstack_version == "v1"
            request(
                :expects => 204,
                :method  => 'DELETE',
                :path    => "vpcs/#{vpc_id}/subnets/#{subnet_id}"
            )
          else
            request(
                :expects => 204,
                :method  => 'DELETE',
                :path    => "subnets/#{subnet_id}"
            )
          end
        end
      end

      class Mock
        def delete_subnet(subnet_id, vpc_id)
          response = Excon::Response.new
          if list_subnets.body['subnets'].map { |r| r['id'] }.include? subnet_id
            data[:subnets].delete(subnet_id)
            response.status = 204
            response
          else
            raise Fog::Network::OpenStack::NotFound
          end
        end
      end
    end
  end
end
