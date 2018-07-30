require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/host'

module Fog
  module Compute
    class HuaweiCloud
      class Hosts < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::Host

        def all(options = {})
          data = service.list_hosts(options)
          load_response(data, 'hosts')
        end

        def get(host_name)
          if host = service.get_host_details(host_name).body['host']
            new('host_name' => host_name,
                'details'   => host)
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
