require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  let(:transaction) {
    Transaction.create!(
      uuid: "MyString",
      amount: 1,
      status: "MyString",
      customer_email: "MyString",
      customer_phone: "MyString"
    )
  }

  before(:each) do
    assign(:transaction, transaction)
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(transaction), "post" do

      assert_select "input[name=?]", "transaction[uuid]"

      assert_select "input[name=?]", "transaction[amount]"

      assert_select "input[name=?]", "transaction[status]"

      assert_select "input[name=?]", "transaction[customer_email]"

      assert_select "input[name=?]", "transaction[customer_phone]"
    end
  end
end
