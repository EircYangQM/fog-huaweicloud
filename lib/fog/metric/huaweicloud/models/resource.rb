require 'fog/huaweicloud/models/model'

module Fog
  module Metric
    class HuaweiCloud
      class Resource < Fog::HuaweiCloud::Model
        identity :id

        attribute :original_resource_id
        attribute :project_id
        attribute :user_id
        attribute :metrics
      end
    end
  end
end
