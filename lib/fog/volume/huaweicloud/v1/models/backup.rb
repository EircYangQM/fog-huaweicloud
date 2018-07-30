require 'fog/volume/huaweicloud/models/backup'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class Backup < Fog::Volume::HuaweiCloud::Backup
          identity :id

          superclass.attributes.each { |attrib| attribute attrib }
        end
      end
    end
  end
end
