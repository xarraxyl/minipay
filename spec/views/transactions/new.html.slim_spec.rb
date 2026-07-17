require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      uuid: "MyString",
      amount: 1,
      type: "Transactions::Authorize",
      status: :approved,
      customer_email: "MyString",
      customer_phone: "MyString"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do
      assert_select "input[name=?]", "transaction[uuid]"

      assert_select "input[name=?]", "transaction[amount]"

      assert_select "input[name=?]", "transaction[status]"

      assert_select "input[name=?]", "transaction[customer_email]"

      assert_select "input[name=?]", "transaction[customer_phone]"
    end
  end
end
