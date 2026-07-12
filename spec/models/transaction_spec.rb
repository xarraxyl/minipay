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

      expect(transaction).to have_error(:amount, :blank)
    end

    it "cannot be negative" do
      transaction = build(:transaction, amount: -1337)

      transaction.valid?

      expect(transaction).to have_error(:amount, :greater_than)
    end
  end

  context "uuid" do
    it "is assigned on create" do
      expect(create(:transaction).uuid).to be_uuid
    end

    it "cannot be nil" do
      transaction = build(:transaction, uuid: nil)

      transaction.valid?

      expect(transaction).to have_error(:uuid, :blank)
    end

    it "must be valid" do
      transaction = build(:transaction, uuid: "not-uuid-string")

      transaction.valid?

      expect(transaction.uuid).not_to be_uuid
      expect(transaction).to have_error(:uuid, :not_uuid)
    end
  end

  context "email" do
    it "must be valid" do
      transaction = build(:transaction, customer_email: "not-email")

      transaction.valid?

      expect(transaction).to have_error(:customer_email, :not_email)
    end
  end
end
