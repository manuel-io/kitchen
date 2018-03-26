require 'test_helper'

class VegetablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vegetable = vegetables(:one)
  end

  test "should get index" do
    get vegetables_url
    assert_response :success
  end

  test "should get new" do
    get new_vegetable_url
    assert_response :success
  end

  test "should create vegetable" do
    assert_difference('Vegetable.count') do
      post vegetables_url, params: { vegetable: { amount: @vegetable.amount, price: @vegetable.price, title: @vegetable.title } }
    end

    assert_redirected_to vegetable_url(Vegetable.last)
  end

  test "should show vegetable" do
    get vegetable_url(@vegetable)
    assert_response :success
  end

  test "should get edit" do
    get edit_vegetable_url(@vegetable)
    assert_response :success
  end

  test "should update vegetable" do
    patch vegetable_url(@vegetable), params: { vegetable: { amount: @vegetable.amount, price: @vegetable.price, title: @vegetable.title } }
    assert_redirected_to vegetable_url(@vegetable)
  end

  test "should destroy vegetable" do
    assert_difference('Vegetable.count', -1) do
      delete vegetable_url(@vegetable)
    end

    assert_redirected_to vegetables_url
  end
end
