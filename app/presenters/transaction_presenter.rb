class TransactionPresenter
  attr_reader :transaction, :h
  delegate :uuid, :status, :customer_phone, to: :transaction

  def initialize(transaction, h)
    @transaction = transaction
    @h = h
  end

  def amount
    "$ #{transaction.amount.to_f / 100}"
  end

  def customer_email
    h.link_to(transaction.customer_email, "mailto:#{transaction.customer_email}", class: "customer-email-link")
  end

  def to_table_row
    h.render partial: 'transactions/table_row', locals: { presenter: self }
  end
end
