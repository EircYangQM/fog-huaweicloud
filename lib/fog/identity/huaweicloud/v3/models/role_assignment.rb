require 'fog/huaweicloud/models/model'

module Fog
  module Identity
    class HuaweiCloud
      class V3
        class RoleAssignment < Fog::HuaweiCloud::Model
          attribute :scope
          attribute :role
          attribute :user
          attribute :group
          attribute :links

          def to_s
            links['assignment']
          end
        end
      end
    end
  end
end
