require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/backup'
require 'fog/volume/huaweicloud/models/backups'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class Backups < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::Backup
          include Fog::Volume::HuaweiCloud::Backups
        end
      end
    end
  end
end
