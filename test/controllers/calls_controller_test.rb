require 'test_helper'

class CallsControllerTest < ActionDispatch::IntegrationTest
  test "should get twiliojwt" do
    get calls_twiliojwt_url
    assert_response :success
  end

end
