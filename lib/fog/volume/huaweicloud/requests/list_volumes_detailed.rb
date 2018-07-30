module Fog
  module Volume
    class HuaweiCloud
      module Real
        def list_volumes_detailed(options = {})
          request(
            :expects => 200,
            :method  => 'GET',
            :path    => 'volumes/detail',
            :query   => options
          )
        end
      end
    end
  end
end
