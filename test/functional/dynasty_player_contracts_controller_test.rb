require 'test_helper'

class DynastyPlayerContractsControllerTest < ActionController::TestCase
  setup do
    @dynasty_player_contract = dynasty_player_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dynasty_player_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dynasty_player_contract" do
    assert_difference('DynastyPlayerContract.count') do
      post :create, dynasty_player_contract: @dynasty_player_contract.attributes
    end

    assert_redirected_to dynasty_player_contract_path(assigns(:dynasty_player_contract))
  end

  test "should show dynasty_player_contract" do
    get :show, id: @dynasty_player_contract.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dynasty_player_contract.to_param
    assert_response :success
  end

  test "should update dynasty_player_contract" do
    put :update, id: @dynasty_player_contract.to_param, dynasty_player_contract: @dynasty_player_contract.attributes
    assert_redirected_to dynasty_player_contract_path(assigns(:dynasty_player_contract))
  end

  test "should destroy dynasty_player_contract" do
    assert_difference('DynastyPlayerContract.count', -1) do
      delete :destroy, id: @dynasty_player_contract.to_param
    end

    assert_redirected_to dynasty_player_contracts_path
  end
end
