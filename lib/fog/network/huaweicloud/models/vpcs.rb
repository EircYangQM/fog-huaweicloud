require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/vpc'

module Fog
  module Network
    class HuaweiCloud
      class Vpcs < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::Vpc

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_vpcs(filters), 'vpcs')
        end

        def get(vpc_id)
          if vpc = service.get_vpc(vpc_id).body['vpc']
            new(vpc)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
