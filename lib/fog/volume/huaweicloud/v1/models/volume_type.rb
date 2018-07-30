require 'fog/volume/huaweicloud/models/volume_type'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class VolumeType < Fog::Volume::HuaweiCloud::VolumeType
          identity :id

          attribute :name
          attribute :volume_backend_name
        end
      end
    end
  end
end
