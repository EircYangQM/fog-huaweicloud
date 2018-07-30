require 'fog/huaweicloud/models/model'

module Fog
  module Monitoring
    class HuaweiCloud
      class AlarmCount < Fog::HuaweiCloud::Model
        attribute :links
        attribute :columns
        attribute :counts

        def to_s
          name
        end
      end
    end
  end
end
