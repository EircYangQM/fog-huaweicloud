require 'fog/huaweicloud/models/collection'
require 'fog/identity/huaweicloud/v3/models/role'

module Fog
  module Identity
    class HuaweiCloud
      class V3
        class RoleAssignments < Fog::HuaweiCloud::Collection
          model Fog::Identity::HuaweiCloud::V3::RoleAssignment

          def all(options = {})
            load_response(service.list_role_assignments(options), 'role_assignments')
          end

          def filter_by(options = {})
            Fog::Logger.deprecation("Calling HuaweiCloud[:keystone].role_assignments.filter_by(options) method which"\
                                    " is not part of standard interface and is deprecated, call "\
                                    " .role_assignments.all(options) or .role_assignments.summary(options) instead.")
            all(options)
          end
        end
      end
    end
  end
end
