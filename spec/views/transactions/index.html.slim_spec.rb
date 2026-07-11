require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        uuid: "Uuid",
        amount: 2,
        status: "Status",
        customer_email: "Customer Email",
        customer_phone: "Customer Phone"
      ),
      Transaction.create!(
        uuid: "Uuid",
        amount: 2,
        status: "Status",
        customer_email: "Customer Email",
        customer_phone: "Customer Phone"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Uuid".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Customer Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Customer Phone".to_s), count: 2
  end
end
