

module Fog
  module HuaweiCloud
    class Planning < Fog::Service
      SUPPORTED_VERSIONS = /v2/

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

      ## MODELS
      #
      model_path 'fog/planning/huaweicloud/models'
      model       :role
      collection  :roles
      model       :plan
      collection  :plans

      ## REQUESTS
      #
      request_path 'fog/planning/huaweicloud/requests'

      # Role requests
      request :list_roles

      # Plan requests
      request :list_plans
      request :get_plan_templates
      request :get_plan
      request :patch_plan
      request :create_plan
      request :delete_plan
      request :add_role_to_plan
      request :remove_role_from_plan

      class Mock
        def self.data
          @data ||= {}
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          @huaweicloud_username = options[:huaweicloud_username]
          @huaweicloud_tenant   = options[:huaweicloud_tenant]
          @huaweicloud_auth_uri = URI.parse(options[:huaweicloud_auth_url])

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:huaweicloud_auth_url])
          management_url.port = 9292
          management_url.path = '/v1'
          @huaweicloud_management_url = management_url.to_s

          @data ||= {:users => {}}
          unless @data[:users].find { |u| u['name'] == options[:huaweicloud_username] }
            id = Fog::Mock.random_numbers(6).to_s
            @data[:users][id] = {
              'id'       => id,
              'name'     => options[:huaweicloud_username],
              'email'    => "#{options[:huaweicloud_username]}@mock.com",
              'tenantId' => Fog::Mock.random_numbers(6).to_s,
              'enabled'  => true
            }
          end
        end

        def data
          self.class.data[@huaweicloud_username]
        end

        def reset_data
          self.class.data.delete(@huaweicloud_username)
        end

        def credentials
          {:provider                 => 'huaweicloud',
           :huaweicloud_auth_url       => @huaweicloud_auth_uri.to_s,
           :huaweicloud_auth_token     => @auth_token,
           :huaweicloud_region         => @huaweicloud_region,
           :huaweicloud_management_url => @huaweicloud_management_url}
        end
      end

      class Real
        include Fog::HuaweiCloud::Core

        # NOTE: uncommenting this should be treated as api-change!
        # def self.not_found_class
        #   Fog::Planning::HuaweiCloud::NotFound
        # end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['management'] # currently Tuskar is configured as 'management' service in Keystone
          @huaweicloud_service_name           = options[:huaweicloud_service_name]
          @huaweicloud_endpoint_type          = options[:huaweicloud_endpoint_type] || 'adminURL'

          @connection_options               = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          unless @path.match(SUPPORTED_VERSIONS)
            @path = "/v2"
          end
        end
      end
    end

    # TODO: get rid of inconform self.[] & self.new & self.services
    def self.[](service)
      new(:service => service)
    end

    def self.new(attributes)
      attributes = attributes.dup # Prevent delete from having side effects
      service = attributes.delete(:service).to_s.downcase.to_sym
      if services.include?(service)
        require "fog/#{service}/huaweicloud"
        return Fog::HuaweiCloud.const_get(service.to_s.capitalize).new(attributes)
      end
      raise ArgumentError, "HuaweiCloud has no #{service} service"
    end

    def self.services
      # Ruby 1.8.7 compatibility for select returning Array of Arrays (pairs)
      Hash[Fog.services.select { |_service, providers| providers.include?(:huaweicloud) }].keys
    end
  end
end
