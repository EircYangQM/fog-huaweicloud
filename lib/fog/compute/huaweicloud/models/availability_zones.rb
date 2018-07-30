require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/availability_zone'

module Fog
  module Compute
    class HuaweiCloud
      class AvailabilityZones < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::AvailabilityZone

        def all(options = {})
          data = service.list_zones_detailed(options)
          load_response(data, 'availabilityZoneInfo')
        end

        def summary(options = {})
          data = service.list_zones(options)
          load_response(data, 'availabilityZoneInfo')
        end
      end
    end
  end
end
