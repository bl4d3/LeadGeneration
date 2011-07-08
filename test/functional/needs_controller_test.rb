require 'test_helper'

class NeedsControllerTest < ActionController::TestCase
  setup do
    @need = needs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:needs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create need" do
    assert_difference('Need.count') do
      post :create, :need => @need.attributes
    end

    assert_redirected_to need_path(assigns(:need))
  end

  test "should show need" do
    get :show, :id => @need.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @need.to_param
    assert_response :success
  end

  test "should update need" do
    put :update, :id => @need.to_param, :need => @need.attributes
    assert_redirected_to need_path(assigns(:need))
  end

  test "should destroy need" do
    assert_difference('Need.count', -1) do
      delete :destroy, :id => @need.to_param
    end

    assert_redirected_to needs_path
  end
end
