require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/subnet'

module Fog
  module Network
    class HuaweiCloud
      class Subnets < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::Subnet

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_subnets(filters), 'subnets')
        end

        def get(subnet_id)
          if subnet = service.get_subnet(subnet_id).body['subnet']
            new(subnet)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
