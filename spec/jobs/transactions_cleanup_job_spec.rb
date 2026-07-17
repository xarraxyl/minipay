require 'rails_helper'

RSpec.describe TransactionsCleanupJob, type: :job do
  it "deletes old transactions" do
    old_transaction = create(:transaction, created_at: 2.hours.ago)
    new_transaction = create(:transaction, created_at: Time.current)

    expect {
      TransactionsCleanupJob.perform_now
    }.to change { Transaction.count }.by(-1)

    expect(Transaction.exists?(old_transaction.id)).to be_falsy
    expect(Transaction.exists?(new_transaction.id)).to be_truthy
  end
end
