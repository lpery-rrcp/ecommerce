require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get success" do
    get carts_success_url
    assert_response :success
  end

  test "should get cancel" do
    get carts_cancel_url
    assert_response :success
  end
end
