require 'fog/volume/huaweicloud/models/availability_zone'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class AvailabilityZone < Fog::Volume::HuaweiCloud::AvailabilityZone
          identity :zoneName

          attribute :zoneState
        end
      end
    end
  end
end
