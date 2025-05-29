require "test_helper"

class IncomeCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @income_category = income_categories(:one)
  end

  test "should get index" do
    get income_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_income_category_url
    assert_response :success
  end

  test "should create income_category" do
    assert_difference("IncomeCategory.count") do
      post income_categories_url, params: { income_category: {} }
    end

    assert_redirected_to income_category_url(IncomeCategory.last)
  end

  test "should show income_category" do
    get income_category_url(@income_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_income_category_url(@income_category)
    assert_response :success
  end

  test "should update income_category" do
    patch income_category_url(@income_category), params: { income_category: {} }
    assert_redirected_to income_category_url(@income_category)
  end

  test "should destroy income_category" do
    assert_difference("IncomeCategory.count", -1) do
      delete income_category_url(@income_category)
    end

    assert_redirected_to income_categories_url
  end
end
