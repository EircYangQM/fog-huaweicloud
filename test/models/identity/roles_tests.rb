require "test_helper"

describe "Fog::Identity[:huaweicloud] | roles" do
  before do
    @identity = Fog::Identity[:huaweicloud]

    @tenant   = @identity.tenants.create(:name => 'test_user')
    @user     = @identity.users.create(:name => 'test_user', :tenant_id => @tenant.id, :password => 'spoof')
    @role     = @identity.roles(:user => @user, :tenant => @tenant).create(:name => 'test_role')
    @roles    = @identity.roles(:user => @user, :tenant => @tenant)
  end

  after do
    @role.destroy
    @user.destroy
    @tenant.destroy
  end

  describe "success" do
    it "#all" do
      @roles.all.must_be_kind_of Fog::Identity::HuaweiCloud::V2::Roles
    end

    it "#get" do
      @roles.get(@roles.first.id).body.wont_be_nil
    end
  end
end
