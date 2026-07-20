class Transactions::Reversal < Transaction
  belongs_to :authorize_transaction, foreign_key: :parent_id, class_name: "Transactions::Authorize"

  after_create :change_authorized_status_to_reversed

  private

  def change_authorized_status_to_reversed
    authorize_transaction.update(status: :reversed)
  end
end
