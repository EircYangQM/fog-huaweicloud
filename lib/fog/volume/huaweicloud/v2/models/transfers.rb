require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v2/models/transfer'
require 'fog/volume/huaweicloud/models/transfers'

module Fog
  module Volume
    class HuaweiCloud
      class V2
        class Transfers < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V2::Transfer
          include Fog::Volume::HuaweiCloud::Transfers
        end
      end
    end
  end
end
