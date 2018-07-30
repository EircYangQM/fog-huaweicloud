require 'fog/huaweicloud/models/collection'
require 'fog/volume/huaweicloud/v1/models/transfer'
require 'fog/volume/huaweicloud/models/transfers'

module Fog
  module Volume
    class HuaweiCloud
      class V1
        class Transfers < Fog::HuaweiCloud::Collection
          model Fog::Volume::HuaweiCloud::V1::Transfer
          include Fog::Volume::HuaweiCloud::Transfers
        end
      end
    end
  end
end
