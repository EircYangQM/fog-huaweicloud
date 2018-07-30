require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/availability_zone'
require 'fog/volume/huaweicloud/models/availability_zones'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class AvailabilityZones < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::AvailabilityZone
          include Fog::Volume::HuaweiCloud::AvailabilityZones
        end
      end
    end
  end
end
