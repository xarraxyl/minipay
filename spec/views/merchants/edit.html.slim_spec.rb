require 'rails_helper'

RSpec.describe "merchants/edit", type: :view do
  let(:merchant) {
    Merchant.create!(
      name: "MyString",
      description: "MyText",
      email: "MyString",
      status: 1,
      total_transaction_sum: 1
    )
  }

  before(:each) do
    assign(:merchant, merchant)
  end

  it "renders the edit merchant form" do
    render

    assert_select "form[action=?][method=?]", merchant_path(merchant), "post" do
      assert_select "input[name=?]", "merchant[name]"

      assert_select "textarea[name=?]", "merchant[description]"

      assert_select "input[name=?]", "merchant[email]"

      assert_select "input[name=?]", "merchant[status]"

      assert_select "input[name=?]", "merchant[total_transaction_sum]"
    end
  end
end
