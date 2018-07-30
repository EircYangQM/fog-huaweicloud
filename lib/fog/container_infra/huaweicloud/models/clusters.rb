require 'fog/huaweicloud/models/collection'
require 'fog/container_infra/huaweicloud/models/cluster'

module Fog
  module ContainerInfra
    class HuaweiCloud
      class Clusters < Fog::HuaweiCloud::Collection

        model Fog::ContainerInfra::HuaweiCloud::Cluster

        def all
          load_response(service.list_clusters, "clusters")
        end

        def get(cluster_uuid_or_name)
          resource = service.get_cluster(cluster_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
