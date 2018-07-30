require 'fog/huaweicloud/models/collection'
require 'fog/monitoring/huaweicloud/models/alarm_count'

module Fog
  module Monitoring
    class HuaweiCloud
      class AlarmCounts < Fog::HuaweiCloud::Collection
        model Fog::Monitoring::HuaweiCloud::AlarmCount

        def get(options = {})
          load_response(service.get_alarm_counts(options))
        end
      end
    end
  end
end
