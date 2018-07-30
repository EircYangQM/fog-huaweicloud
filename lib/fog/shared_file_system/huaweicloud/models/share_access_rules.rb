require 'fog/huaweicloud/models/collection'
require 'fog/shared_file_system/huaweicloud/models/share_access_rule'

module Fog
  module SharedFileSystem
    class HuaweiCloud
      class ShareAccessRules < Fog::HuaweiCloud::Collection
        model Fog::SharedFileSystem::HuaweiCloud::ShareAccessRule

        attr_accessor :share

        def all
          requires :share
          load_response(service.list_share_access_rules(@share.id), 'access_list')
        end

        def find_by_id(id)
          all.find { |rule| rule.id == id }
        end

        alias get find_by_id

        def new(attributes = {})
          requires :share
          super({:share => @share}.merge!(attributes))
        end
      end
    end
  end
end
