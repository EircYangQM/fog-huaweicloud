require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v1/models/snapshot'
require 'fog/volume/huaweicloud/models/snapshots'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class Snapshots < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V1::Snapshot
          include Fog::Volume::HuaweiCloud::Snapshots
        end
      end
    end
  end
end
