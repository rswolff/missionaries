require 'test_helper'

class JavascriptsControllerTest < ActionController::TestCase
  test "should get missionaries" do
    get :missionaries
    assert_response :success
  end

  test "should get missions" do
    get :missions
    assert_response :success
  end

  test "should get units" do
    get :units
    assert_response :success
  end

  test "should get countries" do
    get :countries
    assert_response :success
  end

end
