require 'fog/huaweicloud/models/model'

module Fog
  module Monitoring
    class HuaweiCloud
      class Statistic < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :dimension
        attribute :columns
        attribute :statistics

        def to_s
          name
        end
      end
    end
  end
end
