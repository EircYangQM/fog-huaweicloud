require 'fog/huaweicloud/models/collection'
require 'fog/compute/huaweicloud/models/snapshot'

module Fog
  module Compute
    class HuaweiCloud
      class Snapshots < Fog::HuaweiCloud::Collection
        model Fog::Compute::HuaweiCloud::Snapshot

        def all(options = {})
          if !options.kind_of?(Hash)
            if options
              Fog::Logger.deprecation('Calling HuaweiCloud[:compute].snapshots.all(true) is deprecated, use .snapshots.all')
            else
              Fog::Logger.deprecation('Calling HuaweiCloud[:compute].snapshots.all(false) is deprecated, use .snapshots.summary')
            end
            load_response(service.list_snapshots(options), 'snapshots')
          else
            load_response(service.list_snapshots_detail(options), 'snapshots')
          end
        end

        def summary(options = {})
          load_response(service.list_snapshots(options), 'snapshots')
        end

        def get(snapshot_id)
          if snapshot = service.get_snapshot_details(snapshot_id).body['snapshot']
            new(snapshot)
          end
        rescue Fog::Compute::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
