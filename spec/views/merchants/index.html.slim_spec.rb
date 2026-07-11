require 'rails_helper'

RSpec.describe "merchants/index", type: :view do
  before(:each) do
    assign(:merchants, [
      Merchant.create!(
        name: "Name",
        description: "MyText",
        email: "Email",
        status: 2,
        total_transaction_sum: 3
      ),
      Merchant.create!(
        name: "Name",
        description: "MyText",
        email: "Email",
        status: 2,
        total_transaction_sum: 3
      )
    ])
  end

  it "renders a list of merchants" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
