module Fog
  module Image
    class HuaweiCloud
      class V1
        class Real
          def set_tenant(tenant)
            @huaweicloud_must_reauthenticate = true
            @huaweicloud_tenant = tenant.to_s
            authenticate
          end
        end

        class Mock
          def set_tenant(_tenant)
            true
          end
        end
      end
    end
  end
end
