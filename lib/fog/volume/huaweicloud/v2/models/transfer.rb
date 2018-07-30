require 'fog/volume/huaweicloud/models/transfer'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class Transfer < Fog::Volume::HuaweiCloud::Transfer
          identity :id

          attribute :auth_key, :aliases => 'authKey'
          attribute :created_at, :aliases => 'createdAt'
          attribute :name
          attribute :volume_id, :aliases => 'volumeId'
        end
      end
    end
  end
end
