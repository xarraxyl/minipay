require "application_system_test_case"

class MerchantsTest < ApplicationSystemTestCase
  setup do
    @merchant = create(:merchant)
    @user = create(:user, merchant: @merchant)
    sign_in(@user)
  end

  test "visiting the index" do
    visit merchants_url

    assert_selector "h1", text: "Merchants"
  end

  test "visit the merchant page" do
    visit merchant_url(@merchant)

    assert_selector "h1", text: @merchant.name
  end

  test "edit a merchant" do
    visit edit_merchant_url(@merchant)

    fill_in "Name", with: "New Merchant Name"
    fill_in "Description", with: "New Merchant Description"
    fill_in "Email", with: "new@email.com"
    select "Active", from: "Status"

    click_on "Update Merchant"

    assert_text "New Merchant Name"
    assert_text "New Merchant Description"
    assert_text "new@email.com"
    assert_equal "active", @merchant.reload.status
  end

  test "delete a merchant" do
    visit merchant_url(@merchant)

    click_on "Destroy this merchant"

    assert_text "Merchant was successfully destroyed"
    assert_current_path merchants_path
  end
end
