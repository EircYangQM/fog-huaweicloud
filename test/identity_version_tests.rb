require 'test_helper'

describe "Fog::Identity[:huaweicloud] | versions" do
  before do
    @old_mock_value = Excon.defaults[:mock]
    @old_credentials = Fog.credentials
  end

  it "v2" do
    Fog.credentials = {:huaweicloud_auth_url => 'http://huaweicloud:35357/v2.0/tokens'}

    assert(Fog::Identity::HuaweiCloud::V2::Mock) do
      Fog::Identity[:huaweicloud].class
    end
  end

  it "v3" do
    Fog.credentials = {:huaweicloud_auth_url => 'http://huaweicloud:35357/v3/auth/tokens'}

    assert(Fog::Identity::HuaweiCloud::V3::Mock) do
      Fog::Identity[:huaweicloud].class
    end
  end

  after do
    Excon.defaults[:mock] = @old_mock_value
    Fog.credentials = @old_credentials
  end
end
