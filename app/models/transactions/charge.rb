class Transactions::Charge < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id, class_name: "Transactions::Authorize"
  has_one :refund_transaction, foreign_key: :parent_id, class_name: "Transactions::Refund"
end
