require 'fog/huaweicloud/models/collection'
require 'fog/metering/huaweicloud/models/resource'

module Fog
  module Metering
    class HuaweiCloud
      class Resources < Fog::HuaweiCloud::Collection
        model Fog::Metering::HuaweiCloud::Resource

        def all(_detailed = true)
          load_response(service.list_resources)
        end

        def find_by_id(resource_id)
          resource = service.get_resource(resource_id).body
          new(resource)
        rescue Fog::Metering::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
