require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/key_pair'

module Fog
  module Compute
    class HuaweiCloud
      class KeyPairs < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::KeyPair

        def all(options = {})
          items = []
          service.list_key_pairs(options).body['keypairs'].each do |kp|
            items += kp.values
          end
          # TODO: convert to load_response?
          load(items)
        end

        def get(key_pair_name)
          if key_pair_name
            all.select { |kp| kp.name == key_pair_name }.first
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
