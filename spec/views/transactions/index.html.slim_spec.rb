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

    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Uuid".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("real@email.com".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Customer Phone".to_s), count: 2
  end
end
