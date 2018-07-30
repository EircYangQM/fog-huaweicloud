require 'fog/huaweicloud/models/collection'
require 'fog/event/huaweicloud/models/event'

module Fog
  module Event
    class HuaweiCloud
      class Events < Fog::HuaweiCloud::Collection
        model Fog::Event::HuaweiCloud::Event

        def all(q = [])
          load_response(service.list_events(q))
        end

        def find_by_id(message_id)
          event = service.get_event(message_id).body
          new(event)
        rescue Fog::Event::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
