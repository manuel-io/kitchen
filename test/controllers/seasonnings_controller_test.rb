require 'test_helper'

class SeasonningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seasonning = seasonnings(:one)
  end

  test "should get index" do
    get seasonnings_url
    assert_response :success
  end

  test "should get new" do
    get new_seasonning_url
    assert_response :success
  end

  test "should create seasonning" do
    assert_difference('Seasonning.count') do
      post seasonnings_url, params: { seasonning: { amount: @seasonning.amount, price: @seasonning.price, title: @seasonning.title } }
    end

    assert_redirected_to seasonning_url(Seasonning.last)
  end

  test "should show seasonning" do
    get seasonning_url(@seasonning)
    assert_response :success
  end

  test "should get edit" do
    get edit_seasonning_url(@seasonning)
    assert_response :success
  end

  test "should update seasonning" do
    patch seasonning_url(@seasonning), params: { seasonning: { amount: @seasonning.amount, price: @seasonning.price, title: @seasonning.title } }
    assert_redirected_to seasonning_url(@seasonning)
  end

  test "should destroy seasonning" do
    assert_difference('Seasonning.count', -1) do
      delete seasonning_url(@seasonning)
    end

    assert_redirected_to seasonnings_url
  end
end
