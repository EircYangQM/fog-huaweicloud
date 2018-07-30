require 'fog/huaweicloud/models/collection'
require 'fog/metric/huaweicloud/models/resource'

module Fog
  module Metric
    class HuaweiCloud
      class Resources < Fog::HuaweiCloud::Collection

        model Fog::Metric::HuaweiCloud::Resource

        def all(options = {})
          load_response(service.list_resources(options))
        end

        def find_by_id(resource_id)
          resource = service.get_resource(resource_id).body
          new(resource)
        rescue Fog::Metric::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
