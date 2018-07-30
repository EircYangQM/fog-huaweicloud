module Fog
  module KeyManager
    class HuaweiCloud < Fog::Service
      SUPPORTED_VERSIONS = /v1(\.0)*/

      requires :huaweicloud_auth_url
      recognizes :huaweicloud_auth_token, :huaweicloud_management_url,
                 :persistent, :huaweicloud_service_type, :huaweicloud_service_name,
                 :huaweicloud_tenant, :huaweicloud_tenant_id, :huaweicloud_userid,
                 :huaweicloud_api_key, :huaweicloud_username, :huaweicloud_identity_endpoint,
                 :current_user, :current_tenant, :huaweicloud_region,
                 :huaweicloud_endpoint_type, :huaweicloud_auth_omit_default_port,
                 :huaweicloud_project_name, :huaweicloud_project_id,
                 :huaweicloud_project_domain, :huaweicloud_user_domain, :huaweicloud_domain_name,
                 :huaweicloud_project_domain_id, :huaweicloud_user_domain_id, :huaweicloud_domain_id,
                 :huaweicloud_identity_prefix, :huaweicloud_temp_url_key, :huaweicloud_cache_ttl


      ## MODELS
      #
      model_path 'fog/key_manager/huaweicloud/models'
      model       :secret
      collection  :secrets
      model       :container
      collection  :containers
      model       :acl

      ## REQUESTS

      # secrets
      request_path 'fog/key_manager/huaweicloud/requests'
      request :create_secret
      request :list_secrets
      request :get_secret
      request :get_secret_payload
      request :get_secret_metadata
      request :delete_secret

      # containers
      request :create_container
      request :get_container
      request :list_containers
      request :delete_container

      #ACL
      request :get_secret_acl
      request :update_secret_acl
      request :replace_secret_acl
      request :delete_secret_acl

      request :get_container_acl
      request :update_container_acl
      request :replace_container_acl
      request :delete_container_acl

      class Mock
        def initialize(options = {})
          @huaweicloud_username = options[:huaweicloud_username]
          @huaweicloud_tenant   = options[:huaweicloud_tenant]
          @huaweicloud_auth_uri = URI.parse(options[:huaweicloud_auth_url])

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:huaweicloud_auth_url])
          management_url.port = 9311
          management_url.path = '/v1'
          @huaweicloud_management_url = management_url.to_s

          @data ||= {:users => {}}
          unless @data[:users].detect { |u| u['name'] == options[:huaweicloud_username] }
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

        def self.not_found_class
          Fog::KeyManager::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['key-manager']
          @huaweicloud_service_name           = options[:huaweicloud_service_name]
          @connection_options               = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          @path.sub!(%r{/$}, '')
          unless @path.match(SUPPORTED_VERSIONS)
            @path = supported_version(SUPPORTED_VERSIONS, @huaweicloud_management_uri, @auth_token, @connection_options)
          end
        end

        def supported_version(supported_versions, uri, auth_token, connection_options = {})
          connection = Fog::Core::Connection.new("#{uri.scheme}://#{uri.host}:#{uri.port}", false, connection_options)
          response = connection.request({ :expects => [200, 204, 300],
                                          :headers => {'Content-Type' => 'application/json',
                                                       'Accept' => 'application/json',
                                                       'X-Auth-Token' => auth_token},
                                          :method => 'GET'
                                        })

          body = Fog::JSON.decode(response.body)
          version = nil

          versions =  body.fetch('versions',{}).fetch('values',[])
          versions.each do |v|
            if v.fetch('id', "").match(supported_versions) &&
              ['current', 'supported', 'stable'].include?(v.fetch('status','').downcase)
              version = v['id']
            end
          end

          if !version  || version.empty?
            raise Fog::HuaweiCloud::Errors::ServiceUnavailable.new(
                    "HuaweiCloud service only supports API versions #{supported_versions.inspect}")
          end

          version
        end

      end
    end
  end
end
