require 'fog/huaweicloud/models/collection'
require 'fog/shared_file_system/huaweicloud/models/availability_zone'

module Fog
  module SharedFileSystem
    class HuaweiCloud
      class AvailabilityZones < Fog::HuaweiCloud::Collection
        model Fog::SharedFileSystem::HuaweiCloud::AvailabilityZone

        def all
          load_response(service.list_availability_zones(), 'availability_zones')
        end
      end
    end
  end
end
