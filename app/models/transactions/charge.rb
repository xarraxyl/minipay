class Transactions::Charge < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id, class_name: "Transactions::Authorize"
  has_one :refund_transaction, foreign_key: :parent_id, class_name: "Transactions::Refund"

  after_create :add_to_total_transaction_sum

  private

  def add_to_total_transaction_sum
    merchant.increment!(:total_transaction_sum, amount)
  end
end
