require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    assign(:transaction, Transaction.create!(
      uuid: SecureRandom.uuid,
      amount: 2,
      status: :approved,
      type: "Transactions::Authorize",
      merchant: Merchant.create,
      customer_email: "real@email.com",
      customer_phone: "+420 343 345 677"
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
