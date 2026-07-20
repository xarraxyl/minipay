class Transactions::Refund < Transaction
  belongs_to :charge_transaction, foreign_key: :parent_id, class_name: "Transactions::Charge"

  after_create :remove_from_total_transaction_sum
  after_create :change_charge_transaction_status_to_refunded

  private

  def remove_from_total_transaction_sum
    merchant.decrement!(:total_transaction_sum, amount)
  end

  def change_charge_transaction_status_to_refunded
    charge_transaction.update(status: "refunded")
  end
end
