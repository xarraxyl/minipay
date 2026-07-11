require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "has a valid factory" do
    transaction = build(:transaction)
    transaction.valid?

    expect(transaction).to be_valid
  end

  context "amount" do
    it "cannot be nil" do
      transaction = build(:transaction, amount: nil)
      transaction.valid?

      expect(transaction.errors.where(:amount, :blank)).to be_present
    end

    it "cannot be negative" do
      transaction = build(:transaction, amount: -1337)
      transaction.valid?

      expect(transaction.errors.where(:amount, :greater_than)).to be_present
    end
  end

  context "uuid" do
    it "cannot be nil" do
      transaction = build(:transaction, uuid: nil)
      transaction.valid?

      expect(transaction.errors.where(:uuid, :blank)).to be_present
    end
  end
end
