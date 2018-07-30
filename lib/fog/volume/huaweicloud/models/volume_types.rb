require 'fog/huaweicloud/models/collection'

module Fog
  module Volume
    class HuaweiCloud
      module VolumeTypes
        def all(options = {})
          response = service.list_volume_types(options)
          load_response(response, 'volume_types')
        end

        def get(volume_type_id)
          if volume_type = service.get_volume_type_details(volume_type_id).body['volume_type']
            new(volume_type)
          end
        rescue Fog::Volume::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
