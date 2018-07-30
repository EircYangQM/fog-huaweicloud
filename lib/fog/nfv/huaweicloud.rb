require 'yaml'

module Fog
  module NFV
    class HuaweiCloud < Fog::Service
      SUPPORTED_VERSIONS = /v1.0/

      requires :huaweicloud_auth_url
      recognizes :huaweicloud_auth_token, :huaweicloud_management_url,
                 :persistent, :huaweicloud_service_type, :huaweicloud_service_name,
                 :huaweicloud_tenant, :huaweicloud_tenant_id,
                 :huaweicloud_api_key, :huaweicloud_username, :huaweicloud_identity_endpoint,
                 :current_user, :current_tenant, :huaweicloud_region,
                 :huaweicloud_endpoint_type,
                 :huaweicloud_project_name, :huaweicloud_project_id,
                 :huaweicloud_project_domain, :huaweicloud_user_domain, :huaweicloud_domain_name,
                 :huaweicloud_project_domain_id, :huaweicloud_user_domain_id, :huaweicloud_domain_id

      ## REQUESTS
      #
      request_path 'fog/nfv/huaweicloud/requests'

      # vnfds requests
      request :list_vnfds
      request :get_vnfd
      request :create_vnfd
      request :delete_vnfd

      # vfns requests
      request :list_vnfs
      request :get_vnf
      request :create_vnf
      request :update_vnf
      request :delete_vnf

      ## MODELS
      #
      model_path 'fog/nfv/huaweicloud/models'
      model       :vnfd
      collection  :vnfds
      model       :vnf
      collection  :vnfs

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :vnfs  => [
                {
                  "status"      => "ACTIVE",
                  "description" => "demo-example",
                  "tenant_id"   => "943b6ff8229a4ec2bed0a306f869a0ea",
                  "instance_id" => "5a9a7d3b-24f5-4226-8d43-262972a1776e",
                  "mgmt_url"    => "{\"vdu1\": \"192.168.0.8\"}",
                  "attributes"  => {"monitoring_policy" => "{\"vdus\": {}}"},
                  "id"          => "cb4cdbd8-cf1a-4758-8d36-40db788a37a1",
                  "name"        => "LadasTest"
                }
              ],
              :vnfds => [
                {
                  "service_types" => [{"service_type" => "vnfd", "id" => "f9211d81-b58a-4849-8d38-e25376c421bd"}],
                  "description"   => "demo-example",
                  "tenant_id"     => "943b6ff8229a4ec2bed0a306f869a0ea",
                  "mgmt_driver"   => "noop",
                  "infra_driver"  => "heat",
                  "attributes"    => {"vnfd" => "template_name: sample-vnfd"},
                  "id"            => "1f8f33cf-8c94-427e-a040-f3e393b773b7",
                  "name"          => "sample-vnfd"
                }
              ]
            }
          end
        end

        def self.reset
          @data = nil
        end

        include Fog::HuaweiCloud::Core

        def initialize(options = {})
          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86_400).iso8601

          initialize_identity options
        end

        def data
          self.class.data[@huaweicloud_username]
        end

        def reset_data
          self.class.data.delete(@huaweicloud_username)
        end
      end

      class Real
        include Fog::HuaweiCloud::Core

        def self.not_found_class
          Fog::NFV::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_service_type  = options[:huaweicloud_service_type] || ['servicevm']
          @huaweicloud_service_name  = options[:huaweicloud_service_name]

          @connection_options = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          unless @path.match(SUPPORTED_VERSIONS)
            @path = "/" + Fog::HuaweiCloud.get_supported_version(
              SUPPORTED_VERSIONS,
              @huaweicloud_management_uri,
              @auth_token,
              @connection_options
            )
          end
        end
      end
    end
  end
end
