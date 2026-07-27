class MerchantPresenter
  attr_reader :merchant, :vc
  delegate :id, :name, :description, :email, :status, :total_transaction_sum, to: :merchant

  def initialize(merchant, view_context)
    @merchant = merchant
    @vc = view_context
  end

  def link
    vc.link_to(merchant.name, vc.merchant_path(merchant.id))
  end

  def total_transaction_sum
    "$ #{merchant.total_transaction_sum.to_f / 100}"
  end

  def status
    status_class = case merchant.status
    when "active"
      "success"
    when "inactive"
      "danger"
    else
      "info"
    end

    vc.tag.span merchant.status, class: "badge text-bg-#{status_class}"
  end

  def email
    vc.link_to(merchant.email, "mailto:#{merchant.email}", class: "email-link")
  end

  def to_table_row
    vc.render partial: "merchants/table_row", locals: { presenter: self }
  end
end
