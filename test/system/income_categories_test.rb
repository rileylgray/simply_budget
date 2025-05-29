require "application_system_test_case"

class IncomeCategoriesTest < ApplicationSystemTestCase
  setup do
    @income_category = income_categories(:one)
  end

  test "visiting the index" do
    visit income_categories_url
    assert_selector "h1", text: "Income categories"
  end

  test "should create income category" do
    visit income_categories_url
    click_on "New income category"

    click_on "Create Income category"

    assert_text "Income category was successfully created"
    click_on "Back"
  end

  test "should update Income category" do
    visit income_category_url(@income_category)
    click_on "Edit this income category", match: :first

    click_on "Update Income category"

    assert_text "Income category was successfully updated"
    click_on "Back"
  end

  test "should destroy Income category" do
    visit income_category_url(@income_category)
    click_on "Destroy this income category", match: :first

    assert_text "Income category was successfully destroyed"
  end
end
