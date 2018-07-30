module Fog
  module Identity
    class HuaweiCloud
      class V3
        class Real
          def create_policy(policy)
            request(
              :expects => [201],
              :method  => 'POST',
              :path    => "policies",
              :body    => Fog::JSON.encode(:policy => policy)
            )
          end
        end

        class Mock
        end
      end
    end
  end
end
