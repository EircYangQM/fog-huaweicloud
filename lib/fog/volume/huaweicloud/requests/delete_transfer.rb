module Fog
  module Volume
    class HuaweiCloud
      module Real
        def delete_transfer(transfer_id)
          request(
            :expects => 202,
            :method  => 'DELETE',
            :path    => "os-volume-transfer/#{transfer_id}"
          )
        end
      end
    end
  end
end
