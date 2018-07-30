require 'fog/huaweicloud/models/model'

module Fog
  module Monitoring
    class HuaweiCloud
      class DimensionValue < Fog::HuaweiCloud::Model
        identity :id

        attribute :metric_name
        attribute :dimension_name
        attribute :values

        def to_s
          name
        end
      end
    end
  end
end
