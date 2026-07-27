class TransactionPresenter
  attr_reader :transaction, :vc
  delegate :uuid, :status, :customer_phone, to: :transaction

  def initialize(transaction, vc)
    @transaction = transaction
    @vc = vc
  end

  def uuid_link
    vc.link_to(uuid, vc.transaction_path(transaction.id))
  end

  def amount
    "$ #{transaction.amount.to_f / 100}"
  end

  def customer_email
    vc.link_to(transaction.customer_email, "mailto:#{transaction.customer_email}", class: "email-link")
  end

  def to_table_row
    vc.render partial: "transactions/table_row", locals: { presenter: self }
  end
end
