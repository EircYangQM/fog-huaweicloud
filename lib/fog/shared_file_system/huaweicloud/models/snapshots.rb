require 'fog/huaweicloud/models/collection'
require 'fog/shared_file_system/huaweicloud/models/snapshot'

module Fog
  module SharedFileSystem
    class HuaweiCloud
      class Snapshots < Fog::HuaweiCloud::Collection
        model Fog::SharedFileSystem::HuaweiCloud::Snapshot

        def all(options = {})
          load_response(service.list_snapshots_detail(options), 'snapshots')
        end

        def find_by_id(id)
          snapshot_hash = service.get_snapshot(id).body['snapshot']
          new(snapshot_hash.merge(:service => service))
        end

        alias get find_by_id

        def destroy(id)
          snapshot = find_by_id(id)
          snapshot.destroy
        end
      end
    end
  end
end
