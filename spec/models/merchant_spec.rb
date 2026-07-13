require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "has many transactions" do
    t1 = create(:transaction)
    merchant = t1.merchant

    expect(merchant.transactions.count).to eq(1)
  end
end
