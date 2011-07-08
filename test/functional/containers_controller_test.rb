require 'test_helper'

class ContainersControllerTest < ActionController::TestCase
  setup do
    @container = containers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:containers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create container" do
    assert_difference('Container.count') do
      post :create, :container => @container.attributes
    end

    assert_redirected_to container_path(assigns(:container))
  end

  test "should show container" do
    get :show, :id => @container.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @container.to_param
    assert_response :success
  end

  test "should update container" do
    put :update, :id => @container.to_param, :container => @container.attributes
    assert_redirected_to container_path(assigns(:container))
  end

  test "should destroy container" do
    assert_difference('Container.count', -1) do
      delete :destroy, :id => @container.to_param
    end

    assert_redirected_to containers_path
  end
end
