require "test_helper"

class Webhooks::AnkaPayControllerTest < ActionDispatch::IntegrationTest
  test "should get receive" do
    get webhooks_anka_pay_receive_url
    assert_response :success
  end
end
