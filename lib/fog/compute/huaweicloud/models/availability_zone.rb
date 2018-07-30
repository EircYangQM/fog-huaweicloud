require 'fog/huaweicloud/models/model'

module Fog
  module Compute
    class HuaweiCloud
      class AvailabilityZone < Fog::HuaweiCloud::Model
        identity :zoneName

        attribute :hosts
        attribute :zoneLabel
        attribute :zoneState

        def to_s
          zoneName
        end
      end
    end
  end
end
