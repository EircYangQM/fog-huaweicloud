require 'fog/huaweicloud/models/model'

module Fog
  module Metric
    class HuaweiCloud
      class Metric < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :resource_id
        attribute :unit
        attribute :created_by_project_id
        attribute :created_by_user_id
        attribute :definition
      end
    end
  end
end
