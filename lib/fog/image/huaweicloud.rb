

module Fog
  module Image
    class HuaweiCloud < Fog::Service
      autoload :V1, 'fog/image/huaweicloud/v1'
      autoload :V2, 'fog/image/huaweicloud/v2'

      # Fog::Image::HuaweiCloud.new() will return a Fog::Image::HuaweiCloud::V2 or a Fog::Image::HuaweiCloud::V1,
      #  choosing the latest available
      def self.new(args = {})
        @huaweicloud_auth_uri = URI.parse(args[:huaweicloud_auth_url]) if args[:huaweicloud_auth_url]
        if inspect == 'Fog::Image::HuaweiCloud'
          service = Fog::Image::HuaweiCloud::V2.new(args) unless args.empty?
          service ||= Fog::Image::HuaweiCloud::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
