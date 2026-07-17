class TransactionsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Transaction.old.destroy_all
  end
end
