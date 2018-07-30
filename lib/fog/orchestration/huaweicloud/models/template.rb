require 'fog/huaweicloud/models/model'

module Fog
  module Orchestration
    class HuaweiCloud
      class Template < Fog::HuaweiCloud::Model
        %w(format description template_version parameters resources content).each do |a|
          attribute a.to_sym
        end
      end
    end
  end
end
