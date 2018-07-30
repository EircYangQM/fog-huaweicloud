require 'fog/huaweicloud/models/collection'
require 'fog/identity/huaweicloud/v2/models/role'

module Fog
  module Identity
    class HuaweiCloud
      class V2
        class Roles < Fog::HuaweiCloud::Collection
          model Fog::Identity::HuaweiCloud::V2::Role

          def all(options = {})
            load_response(service.list_roles(options), 'roles')
          end

          def get(id)
            service.get_role(id)
          end
        end
      end
    end
  end
end
