require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v1/models/volume'
require 'fog/volume/huaweicloud/models/volumes'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class Volumes < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V1::Volume
          include Fog::Volume::HuaweiCloud::Volumes
        end
      end
    end
  end
end
