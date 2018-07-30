require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/ipsec_policy'

module Fog
  module Network
    class HuaweiCloud
      class IpsecPolicies < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::IpsecPolicy

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_ipsec_policies(filters), 'ipsecpolicies')
        end

        def get(ipsec_policy_id)
          if ipsec_policy = service.get_ipsec_policy(ipsec_policy_id).body['ipsecpolicy']
            new(ipsec_policy)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
