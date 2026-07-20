class Transactions::Refund < Transaction
  belongs_to :charge_transaction, foreign_key: :parent_id, class_name: "Transactions::Charge"
end
