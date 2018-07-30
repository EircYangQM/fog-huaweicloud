require 'fog/huaweicloud/models/model'
require 'fog/compute/huaweicloud/models/metadata'

module Fog
  module Compute
    class HuaweiCloud
      class Image < Fog::HuaweiCloud::Model
        identity :id

        attribute :name
        attribute :created_at,  :aliases => 'created'
        attribute :updated_at,  :aliases => 'updated'
        attribute :progress
        attribute :status
        attribute :minDisk
        attribute :minRam
        attribute :server,   :aliases => 'server'
        attribute :size,     :aliases => 'OS-EXT-IMG-SIZE:size'
        attribute :metadata
        attribute :links

        def metadata
          @metadata ||= begin
            Fog::Compute::HuaweiCloud::Metadata.new(:service => service,
                                                  :parent  => self)
          end
        end

        def metadata=(new_metadata = {})
          metas = []
          new_metadata.each_pair { |k, v| metas << {"key" => k, "value" => v} }
          metadata.load(metas)
        end

        def destroy
          requires :id
          service.delete_image(id)
          true
        end

        def ready?
          status == 'ACTIVE'
        end
      end
    end
  end
end
