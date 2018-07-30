require 'fog/huaweicloud/models/collection'
require 'fog/key_manager/huaweicloud/models/container'

module Fog
  module KeyManager
    class HuaweiCloud
      class Containers < Fog::HuaweiCloud::Collection
        model Fog::KeyManager::HuaweiCloud::Container

        def all(options = {})
          load_response(service.list_containers(options), 'containers')
        end

        def get(secret_ref)
          if secret = service.get_container(secret_ref).body
            new(secret)
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end

      end
    end
  end
end