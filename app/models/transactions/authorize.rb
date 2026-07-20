class Transactions::Authorize < ::Transaction
  has_one :charge_transaction, foreign_key: :parent_id, class_name: "Transactions::Charge"
  has_one :reversal_transaction, foreign_key: :parent_id, class_name: "Transactions::Reversal"
end
