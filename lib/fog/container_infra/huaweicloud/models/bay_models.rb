require 'fog/huaweicloud/models/collection'
require 'fog/container_infra/huaweicloud/models/bay_model'

module Fog
  module ContainerInfra
    class HuaweiCloud
      class BayModels < Fog::HuaweiCloud::Collection
        model Fog::ContainerInfra::HuaweiCloud::BayModel

        def all
          load_response(service.list_bay_models, 'baymodels')
        end

        def get(bay_model_uuid_or_name)
          resource = service.get_bay_model(bay_model_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
