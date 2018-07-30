require 'fog/huaweicloud/models/collection'
require 'fog/monitoring/huaweicloud/models/statistic'

module Fog
  module Monitoring
    class HuaweiCloud
      class Statistics < Fog::HuaweiCloud::Collection
        model Fog::Monitoring::HuaweiCloud::Statistic

        def all(options = {})
          load_response(service.list_statistics(options), 'elements')
        end
      end
    end
  end
end
