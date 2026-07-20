class PaymentsController < ApiController
  def create
    merchant = Merchant.find(payment_params[:merchant_id])

    if merchant.active?
      transaction = Transaction.build(payment_params)
      if transaction.valid?
        transaction.save
        head :ok
      else
        head :unprocessable_content
      end
    else
      head :forbidden
    end
  end

  private

  def payment_params
    params.permit(:merchant_id, :status, :amount, :customer_email, :type)
  end
end
