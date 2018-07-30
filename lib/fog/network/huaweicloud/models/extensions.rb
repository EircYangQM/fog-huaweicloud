require 'fog/huaweicloud/models/collection'
require 'fog/network/huaweicloud/models/extension'

module Fog
  module Network
    class HuaweiCloud
      class Extensions < Fog::HuaweiCloud::Collection
        attribute :filters

        model Fog::Network::HuaweiCloud::Extension

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_extensions(filters), 'extensions')
        end

        def get(extension_id)
          if extension = service.get_extension(extension_id).body['extension']
            new(extension)
          end
        rescue Fog::Network::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
