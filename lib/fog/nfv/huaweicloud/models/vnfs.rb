require 'fog/huaweicloud/models/collection'
require 'fog/nfv/huaweicloud/models/vnf'

module Fog
  module NFV
    class HuaweiCloud
      class Vnfs < Fog::HuaweiCloud::Collection
        model Fog::NFV::HuaweiCloud::Vnf

        def all(options = {})
          load_response(service.list_vnfs(options), 'vnfs')
        end

        def get(uuid)
          data = service.get_vnf(uuid).body['vnf']
          new(data)
        rescue Fog::NFV::HuaweiCloud::NotFound
          nil
        end

        def destroy(uuid)
          vnf = get(uuid)
          vnf.destroy
        end
      end
    end
  end
end
