require 'test_helper'

class InterpretersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get interpreters_show_url
    assert_response :success
  end

  test "should get index" do
    get interpreters_index_url
    assert_response :success
  end

end
