module Fog
  module Volume
    class HuaweiCloud
      module Real
        def set_tenant(tenant)
          @huaweicloud_must_reauthenticate = true
          @huaweicloud_tenant = tenant.to_s
          authenticate
        end
      end

      module Mock
        def set_tenant(_tenant)
          true
        end
      end
    end
  end
end
