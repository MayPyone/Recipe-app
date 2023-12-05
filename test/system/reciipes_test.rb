require "application_system_test_case"

class ReciipesTest < ApplicationSystemTestCase
  setup do
    @reciipe = reciipes(:one)
  end

  test "visiting the index" do
    visit reciipes_url
    assert_selector "h1", text: "Reciipes"
  end

  test "should create reciipe" do
    visit reciipes_url
    click_on "New reciipe"

    fill_in "Cooking time", with: @reciipe.cooking_time
    fill_in "Description", with: @reciipe.description
    fill_in "Name", with: @reciipe.name
    fill_in "Preparation time", with: @reciipe.preparation_time
    check "Public" if @reciipe.public
    fill_in "User", with: @reciipe.user_id
    click_on "Create Reciipe"

    assert_text "Reciipe was successfully created"
    click_on "Back"
  end

  test "should update Reciipe" do
    visit reciipe_url(@reciipe)
    click_on "Edit this reciipe", match: :first

    fill_in "Cooking time", with: @reciipe.cooking_time
    fill_in "Description", with: @reciipe.description
    fill_in "Name", with: @reciipe.name
    fill_in "Preparation time", with: @reciipe.preparation_time
    check "Public" if @reciipe.public
    fill_in "User", with: @reciipe.user_id
    click_on "Update Reciipe"

    assert_text "Reciipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Reciipe" do
    visit reciipe_url(@reciipe)
    click_on "Destroy this reciipe", match: :first

    assert_text "Reciipe was successfully destroyed"
  end
end
