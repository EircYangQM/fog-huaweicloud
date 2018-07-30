require 'yaml'

module Fog
  module Introspection
    class HuaweiCloud < Fog::Service
      SUPPORTED_VERSIONS = /v1/

      requires :huaweicloud_auth_url
      recognizes :huaweicloud_auth_token, :huaweicloud_management_url,
                 :persistent, :huaweicloud_service_type, :huaweicloud_service_name,
                 :huaweicloud_tenant, :huaweicloud_tenant_id,
                 :huaweicloud_api_key, :huaweicloud_username, :huaweicloud_identity_endpoint,
                 :current_user, :current_tenant, :huaweicloud_region,
                 :huaweicloud_endpoint_type, :huaweicloud_cache_ttl,
                 :huaweicloud_project_name, :huaweicloud_project_id,
                 :huaweicloud_project_domain, :huaweicloud_user_domain, :huaweicloud_domain_name,
                 :huaweicloud_project_domain_id, :huaweicloud_user_domain_id, :huaweicloud_domain_id

      ## REQUESTS
      #
      request_path 'fog/introspection/huaweicloud/requests'

      # Introspection requests
      request :create_introspection
      request :get_introspection
      request :abort_introspection
      request :get_introspection_details

      # Rules requests
      request :create_rules
      request :list_rules
      request :delete_rules_all
      request :get_rules
      request :delete_rules

      ## MODELS
      #
      model_path 'fog/introspection/huaweicloud/models'
      model       :rules
      collection  :rules_collection

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            # Introspection data is *huge* we load it from a yaml file
            file = "../../../../test/fixtures/introspection.yaml"
            hash[key] = YAML.load(File.read(File.expand_path(file, __FILE__)))
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
          Fog::Introspection::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_service_type  = options[:huaweicloud_service_type] || ['baremetal-introspection']
          @huaweicloud_service_name  = options[:huaweicloud_service_name]

          @connection_options = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          unless @path.match(SUPPORTED_VERSIONS)
            @path = "/v1"
          end
        end
      end
    end
  end
end
