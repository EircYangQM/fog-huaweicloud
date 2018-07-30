

module Fog
  module Orchestration
    class HuaweiCloud < Fog::Service
      requires :huaweicloud_auth_url
      recognizes :huaweicloud_auth_token, :huaweicloud_management_url,
                 :persistent, :huaweicloud_service_type, :huaweicloud_service_name,
                 :huaweicloud_tenant, :huaweicloud_tenant_id,
                 :huaweicloud_api_key, :huaweicloud_username, :huaweicloud_identity_endpoint,
                 :current_user, :current_tenant, :huaweicloud_region,
                 :huaweicloud_endpoint_type, :huaweicloud_cache_ttl,
                 :huaweicloud_project_name, :huaweicloud_project_id,
                 :huaweicloud_project_domain, :huaweicloud_user_domain, :huaweicloud_domain_name,
                 :huaweicloud_project_domain_id, :huaweicloud_user_domain_id, :huaweicloud_domain_id,
                 :huaweicloud_identity_prefix

      model_path 'fog/orchestration/huaweicloud/models'
      model       :stack
      collection  :stacks

      model :resource
      collection :resources

      collection :resource_schemas

      model :event
      collection :events

      model :template
      collection :templates

      request_path 'fog/orchestration/huaweicloud/requests'
      request :abandon_stack
      request :build_info
      request :create_stack
      request :delete_stack
      request :get_stack_template
      request :list_events
      request :list_resource_events
      request :list_resource_types
      request :list_resources
      request :list_stack_data
      request :list_stack_data_detailed
      request :list_stack_events
      request :preview_stack
      request :show_event_details
      request :show_resource_data
      request :show_resource_metadata
      request :show_resource_schema
      request :show_resource_template
      request :show_stack_details
      request :update_stack
      request :patch_stack
      request :validate_template
      request :cancel_update

      module Reflectable
        REFLECTION_REGEX = /\/stacks\/(\w+)\/([\w|-]+)\/resources\/(\w+)/

        def resource
          @resource ||= service.resources.get(r[3], stack)
        end

        def stack
          @stack ||= service.stacks.get(r[1], r[2])
        end

        private

        def reflection
          @reflection ||= REFLECTION_REGEX.match(links[0]['href'])
        end
        alias r reflection
      end

      class Mock
        attr_reader :auth_token
        attr_reader :auth_token_expiration
        attr_reader :current_user
        attr_reader :current_tenant

        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :stacks => {}
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          @huaweicloud_username = options[:huaweicloud_username]
          @huaweicloud_auth_uri = URI.parse(options[:huaweicloud_auth_url])

          @current_tenant = options[:huaweicloud_tenant]

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:huaweicloud_auth_url])
          management_url.port = 8774
          management_url.path = '/v1'
          @huaweicloud_management_url = management_url.to_s

          identity_public_endpoint = URI.parse(options[:huaweicloud_auth_url])
          identity_public_endpoint.port = 5000
          @huaweicloud_identity_public_endpoint = identity_public_endpoint.to_s
        end

        def data
          self.class.data["#{@huaweicloud_username}-#{@current_tenant}"]
        end

        def reset_data
          self.class.data.delete("#{@huaweicloud_username}-#{@current_tenant}")
        end

        def credentials
          {:provider                    => 'huaweicloud',
           :huaweicloud_auth_url          => @huaweicloud_auth_uri.to_s,
           :huaweicloud_auth_token        => @auth_token,
           :huaweicloud_management_url    => @huaweicloud_management_url,
           :huaweicloud_identity_endpoint => @huaweicloud_identity_public_endpoint}
        end
      end

      class Real
        include Fog::HuaweiCloud::Core

        def self.not_found_class
          Fog::Orchestration::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_identity_service_type = options[:huaweicloud_identity_service_type] || 'identity'

          @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['orchestration']
          @huaweicloud_service_name           = options[:huaweicloud_service_name]

          @connection_options               = options[:connection_options] || {}

          authenticate

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end
      end
    end
  end
end
