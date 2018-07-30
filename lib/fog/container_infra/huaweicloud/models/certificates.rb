require 'fog/huaweicloud/models/collection'
require 'fog/container_infra/huaweicloud/models/certificate'

module Fog
  module ContainerInfra
    class HuaweiCloud
      class Certificates < Fog::HuaweiCloud::Collection

        model Fog::ContainerInfra::HuaweiCloud::Certificate

        def create(bay_uuid)
          resource = service.create_certificate(bay_uuid).body
          new(resource)
        end

        def get(bay_uuid)
          resource = service.get_certificate(bay_uuid).body
          new(resource)
        rescue Fog::ContainerInfra::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
