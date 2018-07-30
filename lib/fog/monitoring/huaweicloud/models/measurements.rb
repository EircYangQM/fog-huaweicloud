require 'fog/huaweicloud/models/collection'
require 'fog/monitoring/huaweicloud/models/measurement'

module Fog
  module Monitoring
    class HuaweiCloud
      class Measurements < Fog::HuaweiCloud::Collection
        model Fog::Monitoring::HuaweiCloud::Measurement

        def find(options = {})
          load_response(service.find_measurements(options), 'elements')
        end
      end
    end
  end
end
