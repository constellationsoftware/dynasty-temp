require 'test_helper'

class AutoPicksControllerTest < ActionController::TestCase
  setup do
    @auto_pick = auto_picks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auto_picks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auto_pick" do
    assert_difference('AutoPick.count') do
      post :create, auto_pick: @auto_pick.attributes
    end

    assert_redirected_to auto_pick_path(assigns(:auto_pick))
  end

  test "should show auto_pick" do
    get :show, id: @auto_pick
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auto_pick
    assert_response :success
  end

  test "should update auto_pick" do
    put :update, id: @auto_pick, auto_pick: @auto_pick.attributes
    assert_redirected_to auto_pick_path(assigns(:auto_pick))
  end

  test "should destroy auto_pick" do
    assert_difference('AutoPick.count', -1) do
      delete :destroy, id: @auto_pick
    end

    assert_redirected_to auto_picks_path
  end
end
