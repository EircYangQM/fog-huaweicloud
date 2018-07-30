require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/snapshot'
require 'fog/volume/huaweicloud/models/snapshots'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class Snapshots < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::Snapshot
          include Fog::Volume::HuaweiCloud::Snapshots
        end
      end
    end
  end
end
