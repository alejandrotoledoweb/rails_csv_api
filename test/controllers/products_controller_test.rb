require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get products_upload_url
    assert_response :success
  end
end
