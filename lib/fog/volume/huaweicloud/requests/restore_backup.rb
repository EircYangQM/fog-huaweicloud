module Fog
  module Volume
    class HuaweiCloud
      module Real
        def restore_backup(backup_id, volume_id)
          data = { 'restore' => { 'volume_id' => volume_id } }
          request(
            :expects  => 202,
            :method   => 'POST',
            :path     => "backups/#{backup_id}/restore",
            :body     => Fog::JSON.encode(data)
          )
        end
      end
    end
  end
end
