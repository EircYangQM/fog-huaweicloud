require 'fog/huaweicloud'
require 'time'

auth_url = "http://10.0.0.101:5000/v2.0/tokens"
username = 'admin'
password = 'D78JVyRnzJG8j7Mb6fgpeUMp7'

@connection_params = {
    :huaweicloud_auth_url     => auth_url,
    :huaweicloud_username     => username,
    :huaweicloud_api_key      => password,
}

puts "### SERVICE CONNECTION ###"

event_service = Fog::Event::HuaweiCloud.new(@connection_params)

p event_service

puts "### LIST EVENTS ###"

p event_service.events.all
