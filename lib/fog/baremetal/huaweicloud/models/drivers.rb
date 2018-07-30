require 'fog/huaweicloud/models/collection'
require 'fog/baremetal/huaweicloud/models/driver'

module Fog
  module Baremetal
    class HuaweiCloud
      class Drivers < Fog::HuaweiCloud::Collection
        model Fog::Baremetal::HuaweiCloud::Driver

        def all(options = {})
          load_response(service.list_drivers(options), 'drivers')
        end

        def find_by_name(name)
          new(service.get_driver(name).body)
        end
        alias get find_by_name
      end
    end
  end
end
