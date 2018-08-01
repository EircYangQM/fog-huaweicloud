# HuaweiCloud Metering (Ceilometer)

This document explains how to get started using HuaweiCloud Metering (Ceilometer) with Fog. It assumes you have read the [Getting Started with Fog and the HuaweiCloud](getting_started.md) document.

Fog uses the [HuaweiCloud Metering API](http://docs.openstack.org/developer/ceilometer/webapi/v2.html).

## Metering Service

Get a handle on the Metering service:

```ruby
service = Fog::Metering::HuaweiCloud.new({
  :huaweicloud_auth_url  => 'http://KEYSTONE_HOST:KEYSTONE_PORT/v2.0/tokens', # HuaweiCloud Keystone endpoint
  :huaweicloud_username  => OPEN_STACK_USER,                                  # Your HuaweiCloud Username
  :huaweicloud_tenant    => OPEN_STACK_TENANT,                                # Your tenant id
  :huaweicloud_api_key   => OPEN_STACK_PASSWORD,                              # Your HuaweiCloud Password
  :connection_options  => {}                                                # Optional
})
```

## Events

* `service.events([<query_filter>])`: Return a list of events.
* `service.events.find_by_id(<message_id>)`: Return the event matching message_id, or nil if no such event exists.

### Filter events example

Return events newer than 2016-03-17T09:59:44.606000.

```ruby
query_filter = [{
  'field' => 'start_timestamp',
  'op'    => 'gt',
  'value' => '2016-03-17T09:59:44.606000'
}]

service.events(query_filter)
```

## Resources

* `service.resources`: Return a list of resources.
* `service.resources.find_by_id(<resource_id>)`: Return the resource matching resource_id, or nil if no such resource exists.
