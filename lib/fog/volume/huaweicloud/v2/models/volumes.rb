require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/volume'
require 'fog/volume/huaweicloud/models/volumes'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class Volumes < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::Volume
          include Fog::Volume::HuaweiCloud::Volumes
        end
      end
    end
  end
end
