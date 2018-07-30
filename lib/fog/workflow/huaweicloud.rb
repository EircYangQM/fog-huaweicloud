module Fog
  module Workflow
    class HuaweiCloud < Fog::Service
      # Fog::Workflow::HuaweiCloud.new() will return a Fog::Workflow::HuaweiCloud::V2
      #  Will choose the latest available once Mistral V3 is released.
      def self.new(args = {})
        @huaweicloud_auth_uri = URI.parse(args[:huaweicloud_auth_url]) if args[:huaweicloud_auth_url]
        Fog::Workflow::HuaweiCloud::V2.new(args)
      end
    end
  end
end
