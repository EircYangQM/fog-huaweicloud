require 'fog/huaweicloud/models/collection'
require 'fog/nfv/huaweicloud/models/vnfd'

module Fog
  module NFV
    class HuaweiCloud
      class Vnfds < Fog::HuaweiCloud::Collection
        model Fog::NFV::HuaweiCloud::Vnfd

        def all(options = {})
          load_response(service.list_vnfds(options), 'vnfds')
        end

        def get(uuid)
          data = service.get_vnfd(uuid).body['vnfd']
          new(data)
        rescue Fog::NFV::HuaweiCloud::NotFound
          nil
        end

        def destroy(uuid)
          vnfd = get(uuid)
          vnfd.destroy
        end
      end
    end
  end
end
