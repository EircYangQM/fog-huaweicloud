require 'fog/huaweicloud/models/model'

module Fog
  module Baremetal
    class HuaweiCloud
      class Driver < Fog::HuaweiCloud::Model
        identity :name

        attribute :name
        attribute :hosts

        def properties
          requires :name
          service.get_driver_properties(name).body
        end

        def metadata
          requires :name
          service.get_driver(name).headers
        end
      end
    end
  end
end
