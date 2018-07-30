require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/volume_type'
require 'fog/volume/huaweicloud/models/volume_types'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class VolumeTypes < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::VolumeType
          include Fog::Volume::HuaweiCloud::VolumeTypes
        end
      end
    end
  end
end
