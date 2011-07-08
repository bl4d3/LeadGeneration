require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  setup do
    @place = places(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post :create, :place => @place.attributes
    end

    assert_redirected_to place_path(assigns(:place))
  end

  test "should show place" do
    get :show, :id => @place.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @place.to_param
    assert_response :success
  end

  test "should update place" do
    put :update, :id => @place.to_param, :place => @place.attributes
    assert_redirected_to place_path(assigns(:place))
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete :destroy, :id => @place.to_param
    end

    assert_redirected_to places_path
  end
end
