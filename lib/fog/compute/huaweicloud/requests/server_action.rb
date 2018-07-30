module Fog
  module Compute
    class HuaweiCloud
      class Real
        def server_action(server_id, body, expects = [200, 202])
          request(
            :body    => Fog::JSON.encode(body),
            :expects => expects,
            :method  => 'POST',
            :path    => "servers/#{server_id}/action"
          )
        end
      end
    end
  end
end
