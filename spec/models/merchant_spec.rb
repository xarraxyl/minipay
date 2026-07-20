require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "has many transactions" do
    t1 = create(:transaction)
    merchant = t1.merchant

    expect(merchant.transactions.count).to eq(1)
  end

  it 'separates collections by their STI type' do
    merchant = create(:merchant)
    authorize = create(:authorize_transaction, merchant: merchant)
    charge = create(:charge_transaction, merchant: merchant)

    expect(merchant.transactions).to match_array([ authorize, charge ])
    expect(merchant.authorize_transactions).to contain_exactly(authorize)
    expect(merchant.charge_transactions).to contain_exactly(charge)
    expect(merchant.refund_transactions).to be_empty
  end

  context 'when the merchant has no transactions' do
    it 'can be destroyed successfully' do
      merchant = create(:merchant)

      expect { merchant.destroy }.to change(Merchant, :count).by(-1)
      expect(merchant).to be_destroyed
    end
  end

  context 'when the merchant has existing transactions' do
    it 'refuses to destroy the merchant record' do
      merchant = create(:merchant)
      create(:transaction, merchant: merchant)

      expect { merchant.destroy }.not_to change { Merchant.count }
      expect(merchant).not_to be_destroyed
    end
  end

  # todo total_transaction_sum
end
