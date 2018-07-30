require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/security_group_rule'

module Fog
  module Network
    class HuaweiCloud
      class SecurityGroupRules < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::SecurityGroupRule

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_security_group_rules(filters), 'security_group_rules')
        end

        def get(sec_group_rule_id)
          if sec_group_rule = service.get_security_group_rule(sec_group_rule_id).body['security_group_rule']
            new(sec_group_rule)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
