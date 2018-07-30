require 'fog/huaweicloud/models/collection'
require 'fog/key_manager/huaweicloud/models/secret'

module Fog
  module KeyManager
    class HuaweiCloud
      class Secrets < Fog::HuaweiCloud::Collection
        model Fog::KeyManager::HuaweiCloud::Secret

        def all(options = {})
          load_response(service.list_secrets(options), 'secrets')
        end

        def get(secret_ref)
          if secret = service.get_secret(secret_ref).body
            new(secret)
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end

      end
    end
  end
end