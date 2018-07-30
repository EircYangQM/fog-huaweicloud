require 'fog/image/huaweicloud'

module Fog
  module Image
    class HuaweiCloud
      class V1 < Fog::Service
        SUPPORTED_VERSIONS = /v1(\.(0|1))*/

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

        model_path 'fog/image/huaweicloud/v1/models'

        model       :image
        collection  :images

        request_path 'fog/image/huaweicloud/v1/requests'

        request :list_public_images
        request :list_public_images_detailed
        request :get_image
        request :create_image
        request :update_image
        request :get_image_members
        request :update_image_members
        request :get_shared_images
        request :add_member_to_image
        request :remove_member_from_image
        request :delete_image
        request :get_image_by_id
        request :set_tenant

        class Mock
          def self.data
            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :images => {}
              }
            end
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

          def self.not_found_class
            Fog::Image::HuaweiCloud::NotFound
          end

          def initialize(options = {})
            initialize_identity options

            @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['image']
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
              @path = Fog::HuaweiCloud.get_supported_version_path(SUPPORTED_VERSIONS,
                                                                @huaweicloud_management_uri,
                                                                @auth_token,
                                                                @connection_options)
            end
          end
        end
      end
    end
  end
end
