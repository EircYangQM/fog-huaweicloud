require 'fog/huaweicloud/models/model'
require 'fog/huaweicloud/models/meta_parent'

module Fog
  module Compute
    class HuaweiCloud
      class Metadatum < Fog::HuaweiCloud::Model
        include Fog::Compute::HuaweiCloud::MetaParent

        identity :key
        attribute :value

        def destroy
          requires :identity
          service.delete_meta(collection_name, @parent.id, key)
          true
        end

        def save
          requires :identity, :value
          service.update_meta(collection_name, @parent.id, key, value)
          true
        end
      end
    end
  end
end
