require 'fog/huaweicloud/models/model'

module Fog
  module SharedFileSystem
    class HuaweiCloud
      class AvailabilityZone < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :created_at
        attribute :updated_at
      end
    end
  end
end
