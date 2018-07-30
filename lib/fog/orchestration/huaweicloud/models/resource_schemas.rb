require 'fog/huaweicloud/models/collection'

module Fog
  module Orchestration
    class HuaweiCloud
      class ResourceSchemas < Fog::HuaweiCloud::Collection
        def get(resource_type)
          service.show_resource_schema(resource_type).body
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
