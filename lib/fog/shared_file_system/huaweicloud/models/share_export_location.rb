require 'fog/huaweicloud/models/model'

module Fog
  module SharedFileSystem
    class HuaweiCloud
      class ShareExportLocation < Fog::HuaweiCloud::Model
        identity :id
        
        attribute :share_instance_id
        attribute :path
        attribute :is_admin_only
        attribute :preferred
      end
    end
  end
end
