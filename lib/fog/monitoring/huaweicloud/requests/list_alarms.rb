module Fog
  module Monitoring
    class HuaweiCloud
      class Real
        def list_alarms(options = {})
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "alarms",
            :query   => options
          )
        end
      end

      class Mock
        # def list_alarms(options = {})
        #
        # end
      end
    end
  end
end
