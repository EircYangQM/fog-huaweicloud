require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/ike_policy'

module Fog
  module Network
    class HuaweiCloud
      class IkePolicies < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::IkePolicy

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_ike_policies(filters), 'ikepolicies')
        end

        def get(ike_policy_id)
          if ike_policy = service.get_ike_policy(ike_policy_id).body['ikepolicy']
            new(ike_policy)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
