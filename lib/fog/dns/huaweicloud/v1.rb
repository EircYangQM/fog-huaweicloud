require 'fog/dns/openstack'

module Fog
  module DNS
    class HuaweiCloud
      class V1 < Fog::Service
        requires   :huaweicloud_auth_url
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

        request_path 'fog/dns/huaweicloud/v1/requests'

        request :list_domains

        request :get_quota
        request :update_quota

        class Mock
          def self.data
            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :domains => [{
                  "id"          => "a86dba58-0043-4cc6-a1bb-69d5e86f3ca3",
                  "name"        => "example.org.",
                  "email"       => "joe@example.org",
                  "ttl"         => 7200,
                  "serial"      => 1_404_757_531,
                  "description" => "This is an example zone.",
                  "created_at"  => "2014-07-07T18:25:31.275934",
                  "updated_at"  => ''
                }],
                :quota   => {
                  "api_export_size"   => 1000,
                  "recordset_records" => 20,
                  "domain_records"    => 500,
                  "domain_recordsets" => 500,
                  "domains"           => 100
                }
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
            management_url.port = 9001
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
            {:provider                 => 'openstack',
             :huaweicloud_auth_url       => @huaweicloud_auth_uri.to_s,
             :huaweicloud_auth_token     => @auth_token,
             :huaweicloud_region         => @huaweicloud_region,
             :huaweicloud_management_url => @huaweicloud_management_url}
          end
        end

        class Real
          include Fog::HuaweiCloud::Core

          def self.not_found_class
            Fog::DNS::HuaweiCloud::NotFound
          end

          def initialize(options = {})
            initialize_identity options

            @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['dns']
            @huaweicloud_service_name           = options[:huaweicloud_service_name]

            @connection_options               = options[:connection_options] || {}

            authenticate
            set_api_path
            @persistent = options[:persistent] || false
            @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
          end

          def set_api_path
            # version explicitly set to allow usage also in 'DEPRECATED' mitaka version,
            # where f.i. quota modification was not possible at the time of creation
            @path = '/v1' unless @path =~ /v1/
          end
        end
      end
    end
  end
end
