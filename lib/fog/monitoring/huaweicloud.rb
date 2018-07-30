
module Fog
  module Monitoring
    class HuaweiCloud < Fog::Service
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

      model_path 'fog/monitoring/huaweicloud/models'
      model       :metric
      collection  :metrics
      model       :measurement
      collection  :measurements
      model       :statistic
      collection  :statistics
      model       :notification_method
      collection  :notification_methods
      model       :alarm_definition
      collection  :alarm_definitions
      model       :alarm
      collection  :alarms
      model       :alarm_state
      collection  :alarm_states
      model       :alarm_count
      collection  :alarm_counts
      model       :dimension_value

      request_path 'fog/monitoring/huaweicloud/requests'
      request :create_metric
      request :create_metric_array
      request :list_metrics
      request :list_metric_names

      request :find_measurements

      request :list_statistics

      request :create_notification_method
      request :get_notification_method
      request :list_notification_methods
      request :put_notification_method
      request :patch_notification_method
      request :delete_notification_method

      request :create_alarm_definition
      request :list_alarm_definitions
      request :patch_alarm_definition
      request :update_alarm_definition
      request :get_alarm_definition
      request :delete_alarm_definition

      request :list_alarms
      request :get_alarm
      request :patch_alarm
      request :update_alarm
      request :delete_alarm
      request :get_alarm_counts

      request :list_alarm_state_history_for_specific_alarm
      request :list_alarm_state_history_for_all_alarms

      request :list_dimension_values

      request :list_notification_method_types

      class Real
        include Fog::HuaweiCloud::Core

        def self.not_found_class
          Fog::Monitoring::HuaweiCloud::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @huaweicloud_service_type           = options[:huaweicloud_service_type] || ['monitoring']
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
