require 'fog/huaweicloud/models/model'

module Fog
  module Metering
    class HuaweiCloud
      class Resource < Fog::HuaweiCloud::Model
        identity :resource_id

        attribute :project_id
        attribute :user_id
        attribute :metadata
      end
    end
  end
end
