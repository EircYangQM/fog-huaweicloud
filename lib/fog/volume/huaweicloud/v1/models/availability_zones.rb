require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v1/models/availability_zone'
require 'fog/volume/huaweicloud/models/availability_zones'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class AvailabilityZones < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V1::AvailabilityZone
          include Fog::Volume::HuaweiCloud::AvailabilityZones
        end
      end
    end
  end
end
