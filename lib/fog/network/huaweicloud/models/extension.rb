require 'fog/huaweicloud/models/model'

module Fog
  module Network
    class HuaweiCloud
      class Extension < Fog::HuaweiCloud::Model
        identity :id
        attribute :name
        attribute :links
        attribute :description
        attribute :alias
      end
    end
  end
end
