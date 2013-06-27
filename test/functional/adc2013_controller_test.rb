require 'test_helper'

class Adc2013ControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
