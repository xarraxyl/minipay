require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "is invalid without an amount" do
    transaction = build(:transaction, amount: nil)
    expect(transaction).not_to be_valid
  end
end
