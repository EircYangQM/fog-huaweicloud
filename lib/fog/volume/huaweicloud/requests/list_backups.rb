module Fog
  module Volume
    class HuaweiCloud
      module Real
        def list_backups(options = {})
          request(
            :expects => 200,
            :method  => 'GET',
            :path    => 'backups',
            :query   => options
          )
        end
      end
    end
  end
end
