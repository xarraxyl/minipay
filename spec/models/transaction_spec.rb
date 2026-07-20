require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "has a valid factory" do
    transaction = build(:transaction)

    transaction.valid?

    expect(transaction).to be_valid
  end

  context ".old" do
    it "returns transactions created MORE than 1 hour ago" do
      # recent transaction
      create(:transaction, created_at: Time.current)
      old_transaction = create(:transaction, created_at: 2.hours.ago)

      old_transactions = Transaction.old

      expect(old_transactions.size).to eq(1)
      expect(old_transactions.first).to eq(old_transaction)
    end
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

  context 'parent <-> children' do
    it 'correctly walks up the tree from a refund to its authorization' do
      authorize = create(:authorize_transaction)
      charge = create(:charge_transaction, parent: authorize)
      refund = create(:refund_transaction, parent: charge)

      expect(refund.parent).to eq(charge)
      expect(refund.parent.parent).to eq(authorize)
    end

    it 'allows access to child transactions' do
      authorize = create(:authorize_transaction)
      charge = create(:charge_transaction, parent: authorize)
      reversal = create(:reversal_transaction, parent: authorize)

      expect(authorize.children).to match_array([ charge, reversal ])
    end

    it "status is not error for approved and refunded parent transactions" do
      authorize = create(:authorize_transaction, status: "approved")
      charge = create(:charge_transaction, parent: authorize)

      expect(charge.status).not_to eq("error")
    end

    it "status is error for reversed and error parent transactions" do
      authorize = create(:authorize_transaction, status: "reversed")
      charge = create(:charge_transaction, parent: authorize)

      expect(charge.status).to eq("error")
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

RSpec.describe Transactions::Charge, type: :model do
  context "amount" do
    it "must exist" do
      transaction = build(:charge_transaction, amount: nil)

      transaction.valid?

      expect(transaction).to have_error(:amount, :blank)
    end
  end

  context "the merchant's total_transaction_sum" do
    it "must be increased by a charge transaction" do
      merchant = create(:merchant)

      # NOTE our implementation doesn't have customers - otherwise we would have tests that their balance changes as well
      expect { create(:charge_transaction, amount: 1337, merchant: merchant) }.to change { merchant.total_transaction_sum }.by(1337)
    end
  end
end

RSpec.describe Transactions::Refund, type: :model do
  context "amount" do
    it "must exist" do
      transaction = build(:refund_transaction, amount: nil)

      transaction.valid?

      expect(transaction).to have_error(:amount, :blank)
    end
  end

  context "the merchant's total_transaction_sum" do
    it "must decrease by a refund transaction" do
      merchant = create(:merchant, total_transaction_sum: 10000)

      # NOTE our implementation doesn't have customers - otherwise we would have tests that their balance changes as well
      expect { create(:refund_transaction, amount: 1337, merchant: merchant) }.to change { merchant.total_transaction_sum }.by(-1337)
    end
  end

  it "must change the charge transaction's status to refunded" do
    charge = create(:charge_transaction, status: "approved")

    expect { create(:refund_transaction, parent: charge) }.to change { charge.reload.status }.from("approved").to("refunded")
  end
end

RSpec.describe Transactions::Reversal, type: :model do
  context "amount" do
    it "doesn't need to exist" do
      transaction = build(:reversal_transaction, amount: nil)

      transaction.valid?

      expect(transaction).not_to have_error(:amount, :blank)
    end
  end

  it "must change the authorized transaction's status to reversed" do
    authorize = create(:authorize_transaction, status: "approved")

    expect { create(:reversal_transaction, parent: authorize) }.to change { authorize.reload.status }.from("approved").to("reversed")
  end
end
