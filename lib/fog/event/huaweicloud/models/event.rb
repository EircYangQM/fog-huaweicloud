require 'fog/huaweicloud/models/model'

module Fog
  module Event
    class HuaweiCloud
      class Event < Fog::HuaweiCloud::Model
        identity :message_id

        attribute :event_type
        attribute :generated
        attribute :raw
        attribute :traits
      end
    end
  end
end
