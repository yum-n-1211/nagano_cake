require "test_helper"

class Public::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_orders_show_url
    assert_response :success
  end
end
