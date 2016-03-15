require 'test_helper'

class BicyclesControllerTest < ActionController::TestCase
  setup do
    @bicycle = bicycles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bicycles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bicycle" do
    assert_difference('Bicycle.count') do
      post :create, bicycle: { name: @bicycle.name, price: @bicycle.price, qty: @bicycle.qty }
    end

    assert_redirected_to bicycle_path(assigns(:bicycle))
  end

  test "should show bicycle" do
    get :show, id: @bicycle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bicycle
    assert_response :success
  end

  test "should update bicycle" do
    patch :update, id: @bicycle, bicycle: { name: @bicycle.name, price: @bicycle.price, qty: @bicycle.qty }
    assert_redirected_to bicycle_path(assigns(:bicycle))
  end

  test "should destroy bicycle" do
    assert_difference('Bicycle.count', -1) do
      delete :destroy, id: @bicycle
    end

    assert_redirected_to bicycles_path
  end
end
