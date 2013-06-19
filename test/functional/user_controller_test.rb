require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get roles" do
    get :roles
    assert_response :success
  end

end
