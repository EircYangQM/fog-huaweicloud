require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/security_group'

module Fog
  module Compute
    class HuaweiCloud
      class SecurityGroups < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::SecurityGroup

        def all(options = {})
          load_response(service.list_security_groups(options), 'security_groups')
        end

        def get(security_group_id)
          if security_group_id
            new(service.get_security_group(security_group_id).body['security_group'])
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
