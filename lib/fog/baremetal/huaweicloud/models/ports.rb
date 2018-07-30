require 'fog/huaweicloud/models/collection'
require 'fog/baremetal/huaweicloud/models/port'

module Fog
  module Baremetal
    class HuaweiCloud
      class Ports < Fog::HuaweiCloud::Collection
        model Fog::Baremetal::HuaweiCloud::Port

        def all(options = {})
          load_response(service.list_ports_detailed(options), 'ports')
        end

        def summary(options = {})
          load_response(service.list_ports(options), 'ports')
        end

        def details(options = {})
          Fog::Logger.deprecation("Calling HuaweiCloud[:baremetal].ports.details will be removed, "\
                                  " call .ports.all for detailed list.")
          load(service.list_ports_detailed(options).body['ports'])
        end

        def find_by_uuid(uuid)
          new(service.get_port(uuid).body)
        end
        alias get find_by_uuid

        def destroy(uuid)
          port = find_by_id(uuid)
          port.destroy
        end

        def method_missing(method_sym, *arguments, &block)
          if method_sym.to_s =~ /^find_by_(.*)$/
            load(service.list_ports_detailed($1 => arguments.first).body['ports'])
          else
            super
          end
        end
      end
    end
  end
end
