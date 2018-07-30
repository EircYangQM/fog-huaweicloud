require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/network_ip_availability'

module Fog
  module Network
    class HuaweiCloud
      class NetworkIpAvailabilities < Fog::HuaweiCloud::Collection
        model Fog::Network::HuaweiCloud::NetworkIpAvailability

        def all
          load_response(service.list_network_ip_availabilities, 'network_ip_availabilities')
        end

        def get(network_id)
          if network_ip_availability = service.get_network_ip_availability(network_id).body['network_ip_availability']
            new(network_ip_availability)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
