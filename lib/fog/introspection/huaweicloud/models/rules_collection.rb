require 'fog/huaweicloud/models/collection'
require 'fog/introspection/huaweicloud/models/rules'

module Fog
  module Introspection
    class HuaweiCloud
      class RulesCollection < Fog::HuaweiCloud::Collection
        model Fog::Introspection::HuaweiCloud::Rules

        def all(_options = {})
          load_response(service.list_rules, 'rules')
        end

        def get(uuid)
          data = service.get_rules(uuid).body
          new(data)
        rescue Fog::Introspection::HuaweiCloud::NotFound
          nil
        end

        def destroy(uuid)
          rules = get(uuid)
          rules.destroy
        end

        def destroy_all
          service.delete_rules_all
        end
      end
    end
  end
end
