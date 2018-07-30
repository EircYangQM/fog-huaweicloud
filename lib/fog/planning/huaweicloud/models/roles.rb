require 'fog/huaweicloud/models/collection'
require 'fog/planning/huaweicloud/models/role'

module Fog
  module HuaweiCloud
    class Planning
      class Roles < Fog::HuaweiCloud::Collection
        model Fog::HuaweiCloud::Planning::Role

        def all(options = {})
          load_response(service.list_roles(options))
        end
      end
    end
  end
end
