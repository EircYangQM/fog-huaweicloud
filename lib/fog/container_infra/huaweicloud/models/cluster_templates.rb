require 'fog/huaweicloud/models/collection'
require 'fog/container_infra/huaweicloud/models/cluster_template'

module Fog
  module ContainerInfra
    class HuaweiCloud
      class ClusterTemplates < Fog::HuaweiCloud::Collection

        model Fog::ContainerInfra::HuaweiCloud::ClusterTemplate

        def all
          load_response(service.list_cluster_templates, 'clustertemplates')
        end

        def get(cluster_template_uuid_or_name)
          resource = service.get_cluster_template(cluster_template_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
