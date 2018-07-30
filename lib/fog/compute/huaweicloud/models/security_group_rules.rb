require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/security_group_rule'

module Fog
  module Compute
    class HuaweiCloud
      class SecurityGroupRules < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::SecurityGroupRule

        def get(security_group_rule_id)
          if security_group_rule_id
            body = service.get_security_group_rule(security_group_rule_id).body
            new(body['security_group_rule'])
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
