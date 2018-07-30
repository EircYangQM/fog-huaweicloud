require 'fog/huaweicloud/models/model'

module Fog
  module Compute
    class HuaweiCloud
      class Network < Fog::HuaweiCloud::Model
        identity  :id
        attribute :name
        attribute :addresses
      end
    end
  end
end
