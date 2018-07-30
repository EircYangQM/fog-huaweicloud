require 'fog/huaweicloud/models/collection'

module Fog
  module Volume
    class HuaweiCloud
      module Backups
        def all(options = {})
          load_response(service.list_backups_detailed(options), 'backups')
        end

        def summary(options = {})
          load_response(service.list_backups(options), 'backups')
        end

        def get(backup_id)
          backup = service.get_backup_details(backup_id).body['backup']
          if backup
            new(backup)
          end
        rescue Fog::Volume::HuaweiCloud::NotFound
          nil
        end
      end
    end
  end
end
