

module Fog
  module Identity
    class HuaweiCloud < Fog::Service
      autoload :V2, 'fog/identity/huaweicloud/v2'
      autoload :V3, 'fog/identity/huaweicloud/v3'

      requires :huaweicloud_auth_url
      recognizes :huaweicloud_auth_token, :huaweicloud_management_url, :persistent,
                 :huaweicloud_service_type, :huaweicloud_service_name, :huaweicloud_tenant,
                 :huaweicloud_endpoint_type, :huaweicloud_region, :huaweicloud_domain_id,
                 :huaweicloud_project_name, :huaweicloud_domain_name,
                 :huaweicloud_user_domain, :huaweicloud_project_domain,
                 :huaweicloud_user_domain_id, :huaweicloud_project_domain_id,
                 :huaweicloud_api_key, :huaweicloud_current_user_id, :huaweicloud_userid, :huaweicloud_username,
                 :current_user, :current_user_id, :current_tenant, :huaweicloud_cache_ttl,
                 :provider, :huaweicloud_identity_prefix, :huaweicloud_endpoint_path_matches

      # Fog::Identity::HuaweiCloud.new() will return a Fog::Identity::HuaweiCloud::V3 by default
      def self.new(args = {})
        version = '3'
        url = Fog.credentials[:huaweicloud_auth_url] || args[:huaweicloud_auth_url]
        if url
          uri = URI(url)
          version = '2.0' if uri.path =~ /v2\.0/
        end

        service = case version
                  when '2.0'
                    Fog::Identity::HuaweiCloud::V2.new(args)
                  else
                    Fog::Identity::HuaweiCloud::V3.new(args)
                  end
        service
      end

      class Mock
        attr_reader :config

        def initialize(options = {})
          @huaweicloud_auth_uri = URI.parse(options[:huaweicloud_auth_url])
          @config = options
        end
      end

      class Real
        include Fog::HuaweiCloud::Core

        DEFAULT_SERVICE_TYPE_V3 = %w(identity_v3 identityv3 identity).collect(&:freeze).freeze
        DEFAULT_SERVICE_TYPE    = %w(identity).collect(&:freeze).freeze

        def self.not_found_class
          Fog::Identity::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          if options.respond_to?(:config_service?) && options.config_service?
            configure(options)
            return
          end

          initialize_identity(options)

          @huaweicloud_service_type   = options[:huaweicloud_service_type] || default_service_type(options)
          @huaweicloud_service_name   = options[:huaweicloud_service_name]

          @connection_options       = options[:connection_options] || {}

          @huaweicloud_endpoint_type  = options[:huaweicloud_endpoint_type] || 'adminURL'
          initialize_endpoint_path_matches(options)

          authenticate

          if options[:huaweicloud_identity_prefix]
            @path = "/#{options[:huaweicloud_identity_prefix]}/#{@path}"
          end

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def config_service?
          true
        end

        def config
          self
        end

        private

        def default_service_type(options)
          unless options[:huaweicloud_identity_prefix]
            if @huaweicloud_auth_uri.path =~ %r{/v3} ||
               (options[:huaweicloud_endpoint_path_matches] && options[:huaweicloud_endpoint_path_matches] =~ '/v3')
              return DEFAULT_SERVICE_TYPE_V3
            end
          end
          DEFAULT_SERVICE_TYPE
        end

        def initialize_endpoint_path_matches(options)
          if options[:huaweicloud_endpoint_path_matches]
            @huaweicloud_endpoint_path_matches = options[:huaweicloud_endpoint_path_matches]
          end
        end

        def configure(source)
          source.instance_variables.each do |v|
            instance_variable_set(v, source.instance_variable_get(v))
          end
        end
      end
    end
  end
end
