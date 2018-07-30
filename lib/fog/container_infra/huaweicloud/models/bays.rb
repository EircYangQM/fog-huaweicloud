require 'fog/huaweicloud/models/collection'
require 'fog/container_infra/huaweicloud/models/bay'

module Fog
  module ContainerInfra
    class HuaweiCloud
      class Bays < Fog::HuaweiCloud::Collection
        model Fog::ContainerInfra::HuaweiCloud::Bay

        def all
          load_response(service.list_bays, "bays")
        end

        def get(bay_uuid_or_name)
          resource = service.get_bay(bay_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
