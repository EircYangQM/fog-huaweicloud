require 'fog/huaweicloud/models/model'

module Fog
  module Monitoring
    class HuaweiCloud
      class Measurement < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :dimensions
        attribute :columns
        attribute :measurements

        def to_s
          name
        end
      end
    end
  end
end
