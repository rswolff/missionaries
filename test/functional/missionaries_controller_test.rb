require 'test_helper'

class MissionariesControllerTest < ActionController::TestCase
  setup do
    @missionary = missionaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missionaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create missionary" do
    assert_difference('Missionary.count') do
      post :create, :missionary => @missionary.attributes
    end

    assert_redirected_to missionary_path(assigns(:missionary))
  end

  test "should show missionary" do
    get :show, :id => @missionary.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @missionary.to_param
    assert_response :success
  end

  test "should update missionary" do
    put :update, :id => @missionary.to_param, :missionary => @missionary.attributes
    assert_redirected_to missionary_path(assigns(:missionary))
  end

  test "should destroy missionary" do
    assert_difference('Missionary.count', -1) do
      delete :destroy, :id => @missionary.to_param
    end

    assert_redirected_to missionaries_path
  end
end
