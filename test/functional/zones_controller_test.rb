require 'test_helper'

class ZonesControllerTest < ActionController::TestCase
  setup do
    @zone = zones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zone" do
    assert_difference('Zone.count') do
      post :create, :zone => @zone.attributes
    end

    assert_redirected_to zone_path(assigns(:zone))
  end

  test "should show zone" do
    get :show, :id => @zone.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @zone.to_param
    assert_response :success
  end

  test "should update zone" do
    put :update, :id => @zone.to_param, :zone => @zone.attributes
    assert_redirected_to zone_path(assigns(:zone))
  end

  test "should destroy zone" do
    assert_difference('Zone.count', -1) do
      delete :destroy, :id => @zone.to_param
    end

    assert_redirected_to zones_path
  end
end
