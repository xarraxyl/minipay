require 'rails_helper'

RSpec.describe "merchants/show", type: :view do
  before(:each) do
    assign(:merchant, Merchant.create!(
      name: "Name",
      description: "MyText",
      email: "Email",
      status: "active",
      total_transaction_sum: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/active/)
    expect(rendered).to match(/3/)
  end
end
