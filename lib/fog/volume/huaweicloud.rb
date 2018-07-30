

module Fog
  module Volume
    class HuaweiCloud < Fog::Service
      autoload :V1, 'fog/volume/huaweicloud/v1'
      autoload :V2, 'fog/volume/huaweicloud/v2'

      @@recognizes = [:huaweicloud_auth_token, :huaweicloud_management_url,
                      :persistent, :huaweicloud_service_type, :huaweicloud_service_name,
                      :huaweicloud_tenant, :huaweicloud_tenant_id,
                      :huaweicloud_api_key, :huaweicloud_username, :huaweicloud_identity_endpoint,
                      :current_user, :current_tenant, :huaweicloud_region,
                      :huaweicloud_endpoint_type, :huaweicloud_cache_ttl,
                      :huaweicloud_project_name, :huaweicloud_project_id,
                      :huaweicloud_project_domain, :huaweicloud_user_domain, :huaweicloud_domain_name,
                      :huaweicloud_project_domain_id, :huaweicloud_user_domain_id, :huaweicloud_domain_id,
                      :huaweicloud_identity_prefix]

      # Fog::Image::HuaweiCloud.new() will return a Fog::Volume::HuaweiCloud::V2 or a Fog::Volume::HuaweiCloud::V1,
      #  choosing the V2 by default, as V1 is deprecated since HuaweiCloud Juno
      def self.new(args = {})
        @huaweicloud_auth_uri = URI.parse(args[:huaweicloud_auth_url]) if args[:huaweicloud_auth_url]
        service = if inspect == 'Fog::Volume::HuaweiCloud'
                    Fog::Volume::HuaweiCloud::V2.new(args) || Fog::Volume::HuaweiCloud::V1.new(args)
                  else
                    super
                  end
        service
      end
    end
  end
end
