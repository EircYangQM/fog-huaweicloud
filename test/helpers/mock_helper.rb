# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

if ENV["FOG_MOCK"] == "true"
  Fog.mock!
end

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :huaweicloud_api_key  => 'huaweicloud_api_key',
    :huaweicloud_username => 'huaweicloud_username',
    :huaweicloud_tenant   => 'huaweicloud_tenant',
    :huaweicloud_auth_url => 'http://huaweicloud:35357/v2.0/tokens',
  }.merge(Fog.credentials)
end
