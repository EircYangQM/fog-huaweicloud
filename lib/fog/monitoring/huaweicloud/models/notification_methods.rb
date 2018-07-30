require 'fog/huaweicloud/models/collection'
require 'fog/monitoring/huaweicloud/models/notification_method'

module Fog
  module Monitoring
    class HuaweiCloud
      class NotificationMethods < Fog::HuaweiCloud::Collection
        model Fog::Monitoring::HuaweiCloud::NotificationMethod

        def all(options = {})
          load_response(service.list_notification_methods(options), 'elements')
        end

        def create(attributes)
          super(attributes)
        end

        def patch(attributes)
          super(attributes)
        end

        def find_by_id(id)
          cached_notification_method = detect { |notification_method| notification_method.id == id }
          return cached_notification_method if cached_notification_method
          notification_method_hash = service.get_notification_method(id).body
          Fog::Monitoring::HuaweiCloud::NotificationMethod.new(
            notification_method_hash.merge(:service => service)
          )
        end

        def list_types
          service.list_notification_method_types.body['elements'].map { |x| x['type'].to_sym }
        end

        def destroy(id)
          notification_method = find_by_id(id)
          notification_method.destroy
        end
      end
    end
  end
end
