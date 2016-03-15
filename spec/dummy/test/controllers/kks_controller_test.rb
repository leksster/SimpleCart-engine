require 'test_helper'

class KksControllerTest < ActionController::TestCase
  setup do
    @kk = kks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kk" do
    assert_difference('Kk.count') do
      post :create, kk: { name: @kk.name, price: @kk.price, qty: @kk.qty }
    end

    assert_redirected_to kk_path(assigns(:kk))
  end

  test "should show kk" do
    get :show, id: @kk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kk
    assert_response :success
  end

  test "should update kk" do
    patch :update, id: @kk, kk: { name: @kk.name, price: @kk.price, qty: @kk.qty }
    assert_redirected_to kk_path(assigns(:kk))
  end

  test "should destroy kk" do
    assert_difference('Kk.count', -1) do
      delete :destroy, id: @kk
    end

    assert_redirected_to kks_path
  end
end
