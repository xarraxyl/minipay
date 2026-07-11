require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    assign(:transaction, Transaction.create!(
      uuid: "Uuid",
      amount: 2,
      status: "Status",
      customer_email: "Customer Email",
      customer_phone: "Customer Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Customer Email/)
    expect(rendered).to match(/Customer Phone/)
  end
end
