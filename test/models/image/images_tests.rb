require "test_helper"
describe "Fog::Image[:huaweicloud] | images" do
  before do
    @instance = Fog::Image[:huaweicloud].create_image(:name => "model test image").body
  end

  describe "success" do
    it "#find_by_id" do
      image = Fog::Image[:huaweicloud].images.find_by_id(@instance['image']['id'])
      image.id.must_equal @instance['image']['id']
    end

    it "#get" do
      image = Fog::Image[:huaweicloud].images.get(@instance['image']['id'])
      image.id.must_equal @instance['image']['id']
    end

    it "#destroy" do
      Fog::Image[:huaweicloud].images.destroy(@instance['image']['id']).must_equal true
    end
  end
end
