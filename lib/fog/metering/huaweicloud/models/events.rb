require 'fog/huaweicloud/models/collection'
require 'fog/metering/huaweicloud/models/event'

module Fog
  module Metering
    class HuaweiCloud
      class Events < Fog::HuaweiCloud::Collection
        model Fog::Metering::HuaweiCloud::Event

        def all(q = [])
          load_response(service.list_events(q))
        end

        def find_by_id(message_id)
          event = service.get_event(message_id).body
          new(event)
        rescue Fog::Metering::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
