require 'fog/huaweicloud/models/collection'
require 'fog/monitoring/huaweicloud/models/dimension_value'

module Fog
  module Monitoring
    class HuaweiCloud
      class DimensionValues < Fog::HuaweiCloud::Collection
        model Fog::Monitoring::HuaweiCloud::DimensionValue

        def all(dimension_name, options = {})
          load_response(service.list_dimension_values(dimension_name, options), 'elements')
        end
      end
    end
  end
end
