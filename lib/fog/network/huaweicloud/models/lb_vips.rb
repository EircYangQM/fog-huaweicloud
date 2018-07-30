require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/lb_vip'

module Fog
  module Network
    class HuaweiCloud
      class LbVips < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::LbVip

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lb_vips(filters), 'vips')
        end

        def get(vip_id)
          if vip = service.get_lb_vip(vip_id).body['vip']
            new(vip)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
