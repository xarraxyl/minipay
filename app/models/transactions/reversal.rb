class Transactions::Reversal < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id, class_name: "Transactions::Authorize"
end
