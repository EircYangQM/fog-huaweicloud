require "test_helper"
require 'fog/planning/huaweicloud'

describe "Fog::HuaweiCloud[:planning] | Planning role requests" do
  before do
    @role_format = {
      'description' => Fog::Nullable::String,
      'name'        => Fog::Nullable::String,
      'uuid'        => String,
      'version'     => Integer,
    }
  end

  describe "success" do
    it "#list_roles" do
      Fog::HuaweiCloud[:planning].list_roles.body.must_match_schema([@role_format])
    end
  end
end
