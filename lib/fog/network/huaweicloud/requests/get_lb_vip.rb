module Fog
  module Network
    class HuaweiCloud
      class Real
        def get_lb_vip(vip_id)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "lb/vips/#{vip_id}"
          )
        end
      end

      class Mock
        def get_lb_vip(vip_id)
          response = Excon::Response.new
          if data = self.data[:lb_vips][vip_id]
            response.status = 200
            response.body = {'vip' => data}
            response
          else
            raise Fog::Network::HuaweiCloud::NotFound
          end
        end
      end
    end
  end
end
