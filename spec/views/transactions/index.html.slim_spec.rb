require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        uuid: "ef947632-038d-47e4-b300-ae351075b1a8",
        amount: 2,
        type: "Transactions::Authorize",
        status: :approved,
        merchant: Merchant.create,
        customer_email: "real@email.com",
        customer_phone: "Customer Phone"
      ),
      Transaction.create!(
        uuid: "ef947632-038d-47e4-b300-ae351075b1a7",
        amount: 2,
        type: "Transactions::Authorize",
        merchant: Merchant.create,
        status: :approved,
        customer_email: "real@email.com",
        customer_phone: "Customer Phone"
      )
    ])
  end

  it "renders a list of transactions" do
    render

    assert_select "tbody>tr>td", text: /ef947632-038d-47e4-b300-ae351075b1a8/, count: 1
    assert_select "tbody>tr>td", text: /Approved/i, count: 2
    assert_select "tbody>tr>td", text: /real@email\.com/, count: 2
    assert_select "tbody>tr>td", text: /Customer Phone/, count: 2
  end
end
