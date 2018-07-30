require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/subnet_pool'

module Fog
  module Network
    class HuaweiCloud
      class SubnetPools < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::SubnetPool

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_subnet_pools(filters), 'subnetpools')
        end

        def get(subnet_pool_id)
          subnet_pool = service.get_subnet_pool(subnet_pool_id).body['subnetpool']
          if subnet_pool
            new(subnet_pool)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
