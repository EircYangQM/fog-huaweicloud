module Fog
  module Network
    class HuaweiCloud
      class Real
        def set_tenant(tenant)
          @huaweicloud_must_reauthenticate = true
          @huaweicloud_tenant = tenant.to_s
          authenticate
          set_api_path
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
