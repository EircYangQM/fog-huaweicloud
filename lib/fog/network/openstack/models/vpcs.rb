require 'fog/openstack/models/collection'
require 'fog/network/openstack/models/vpc'

module Fog
  module Network
    class OpenStack
      class Vpcs < Fog::OpenStack::Collection
        attribute :filters

        model Fog::Network::OpenStack::Vpc

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_vpcs(filters), 'vpcs')
        end

        def get(vpc_id)
          if vpc = service.get_vpc(vpc_id).body['vpc']
            new(vpc)
          end
        rescue Fog::Network::OpenStack::NotFound
          nil
        end
      end
    end
  end
end
