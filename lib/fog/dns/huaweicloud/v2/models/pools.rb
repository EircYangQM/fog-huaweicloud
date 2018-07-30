require 'fog/huaweicloud/models/collection'
require 'fog/dns/huaweicloud/v2/models/pool'

module Fog
  module DNS
    class HuaweiCloud
      class V2
        class Pools < Fog::HuaweiCloud::Collection
          model Fog::DNS::HuaweiCloud::V2::Pool

          def all(options = {})
            load_response(service.list_pools(options), 'pools')
          end

          def find_by_id(id, options = {})
            pool_hash = service.get_pool(id, options).body
            new(pool_hash.merge(:service => service))
          end

          alias get find_by_id
        end
      end
    end
  end
end
