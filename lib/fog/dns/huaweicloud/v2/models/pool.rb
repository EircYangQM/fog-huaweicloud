require 'fog/huaweicloud/models/model'

module Fog
  module DNS
    class HuaweiCloud
      class V2
        class Pool < Fog::HuaweiCloud::Model
          identity :id

          attribute :name
          attribute :description
          attribute :ns_records
          attribute :project_id
          attribute :links
          attribute :created_at
          attribute :updated_at
        end
      end
    end
  end
end
