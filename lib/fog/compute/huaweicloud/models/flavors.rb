require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/flavor'

module Fog
  module Compute
    class HuaweiCloud
      class Flavors < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::Flavor

        def all(options = {})
          data = service.list_flavors_detail(options)
          load_response(data, 'flavors')
        end

        def summary(options = {})
          data = service.list_flavors(options)
          load_response(data, 'flavors')
        end

        def get(flavor_id)
          data = service.get_flavor_details(flavor_id).body['flavor']
          new(data)
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
