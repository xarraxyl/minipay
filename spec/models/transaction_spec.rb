require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "has a valid factory" do
    transaction = build(:transaction)

    transaction.valid?

    expect(transaction).to be_valid
  end

  context "amount" do
    it "must exist" do
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

    it "must exist" do
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

  context "status" do
    it "must exist" do
      transaction = build(:transaction, status: nil)

      transaction.valid?

      expect(transaction).to have_error(:status, :blank)
    end

    context "can change between" do
      it "approved -> reversed" do
        transaction = create(:transaction, status: :approved)

        transaction.status = :reversed
        # trigger state change validation without raising
        transaction.save

        expect(transaction).to be_valid
      end

      it "approved -> refunded" do
        transaction = create(:transaction, status: :approved)

        transaction.status = :error
        # trigger state change validation without raising
        transaction.save

        expect(transaction).to be_valid
      end

      it "approved -> error" do
        transaction = create(:transaction, status: :approved)

        transaction.status = :error
        # trigger state change validation without raising
        transaction.save

        expect(transaction).to be_valid
      end
    end

    context "cannot change between" do
      Transaction.statuses.keys.each do |new_status|
        %w[reversed refunded error].each do |irreversible_status|
          # not a change
          next if new_status == irreversible_status

          it "#{irreversible_status} -> #{new_status}" do
            transaction = create(:transaction, status: irreversible_status)

            transaction.status = new_status
            # trigger state change validation without raising
            transaction.save

            expect(transaction).to have_error(:status, :invalid_state_transition)
          end
        end
      end
    end
  end

  context "merchant" do
    it "must exist" do
      transaction = build(:transaction, merchant: nil)

      transaction.valid?

      expect(transaction).to have_error(:merchant, :blank)
    end
  end
end

RSpec.describe Transactions::Authorize, type: :model do
  context "amount" do
    it "must exist" do
      transaction = build(:transaction, amount: nil)

      transaction.valid?

      expect(transaction).to have_error(:amount, :blank)
    end
  end
end


