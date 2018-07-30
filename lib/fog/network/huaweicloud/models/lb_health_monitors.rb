require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/lb_health_monitor'

module Fog
  module Network
    class HuaweiCloud
      class LbHealthMonitors < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::LbHealthMonitor

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lb_health_monitors(filters), 'health_monitors')
        end

        def get(health_monitor_id)
          if health_monitor = service.get_lb_health_monitor(health_monitor_id).body['health_monitor']
            new(health_monitor)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
