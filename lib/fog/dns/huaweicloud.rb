module Fog
  module DNS
    class HuaweiCloud < Fog::Service
      autoload :V1, 'fog/dns/huaweicloud/v1'
      autoload :V2, 'fog/dns/huaweicloud/v2'

      # Fog::DNS::HuaweiCloud.new() will return a Fog::DNS::HuaweiCloud::V2 or a Fog::DNS::HuaweiCloud::V1,
      # choosing the latest available
      def self.new(args = {})
        @huaweicloud_auth_uri = URI.parse(args[:huaweicloud_auth_url]) if args[:huaweicloud_auth_url]
        if inspect == 'Fog::DNS::HuaweiCloud'
          service = Fog::DNS::HuaweiCloud::V2.new(args) unless args.empty?
          service ||= Fog::DNS::HuaweiCloud::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
