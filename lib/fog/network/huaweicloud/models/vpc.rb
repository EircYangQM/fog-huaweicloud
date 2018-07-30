require 'fog/huaweicloud/models/model'

module Fog
  module Network
    class HuaweiCloud
      class Vpc < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :cidr
        attribute :status

        def create
          requires :name, :cidr
          merge_attributes(service.create_vpc(name, cidr).body['vpc'])
          self
        end

        # TODO not support
        # def update
        #   requires :id
        #   merge_attributes(service.update_subnet(id, attributes).body['subnet'])
        #   self
        # end

        def destroy
          requires :id
          service.delete_vpc(id)
          true
        end
      end
    end
  end
end
