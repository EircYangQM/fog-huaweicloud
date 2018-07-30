require 'fog/huaweicloud/models/collection'

module Fog
  module Volume
    class HuaweiCloud
      module AvailabilityZones
        def all(options = {})
          data = service.list_zones(options)
          load_response(data, 'availabilityZoneInfo')
        end
      end
    end
  end
end
