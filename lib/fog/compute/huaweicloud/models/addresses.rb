require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/address'

module Fog
  module Compute
    class HuaweiCloud
      class Addresses < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::Address

        def all(options = {})
          load_response(service.list_all_addresses(options), 'floating_ips')
        end

        def get(address_id)
          if address = service.get_address(address_id).body['floating_ip']
            new(address)
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end

        def get_address_pools
          service.list_address_pools.body['floating_ip_pools']
        end
      end
    end
  end
end
