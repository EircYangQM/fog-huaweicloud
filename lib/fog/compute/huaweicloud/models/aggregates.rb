require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/aggregate'

module Fog
  module Compute
    class HuaweiCloud
      class Aggregates < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::Aggregate

        def all(options = {})
          load_response(service.list_aggregates(options), 'aggregates')
        end

        def find_by_id(id)
          new(service.get_aggregate(id).body['aggregate'])
        end
        alias get find_by_id

        def destroy(id)
          aggregate = find_by_id(id)
          aggregate.destroy
        end
      end
    end
  end
end
