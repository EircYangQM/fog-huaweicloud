module Fog
  module Network
    class OpenStack
      class Real
        def create_vpc(name, cidr)
          if @openstack_version == "v1"
            data = {
                'vpc' => {
                    'name' => name,
                    'cidr' => cidr
                }
            }

            # vanilla_options = [:name, :gateway_ip, :allocation_pools,
            #                    :dns_nameservers, :host_routes, :enable_dhcp,
            #                    :tenant_id, :vpc_id]
            # vanilla_options.select { |o| options.key?(o) }.each do |key|
            #   data['vpc'][key] = options[key]
            # end

            request(
                :body    => Fog::JSON.encode(data),
                :expects => [200],
                :method  => 'POST',
                :path    => 'vpcs'
            )
          else
            raise Fog::OpenStack::Errors::InterfaceNotImplemented.new('Method :create_subnet is not implemented')
          end
        end
      end

      class Mock
        def create_vpc(name, cidr)
          raise Fog::OpenStack::Errors::InterfaceNotImplemented.new('Method :create_vpc is not implemented')
        end
      end
    end
  end
end
