require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v1/models/backup'
require 'fog/volume/huaweicloud/models/backups'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class Backups < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V1::Backup
          include Fog::Volume::HuaweiCloud::Backups
        end
      end
    end
  end
end
