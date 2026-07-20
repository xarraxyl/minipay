require 'rails_helper'

RSpec.describe "Payments", type: :request do
  describe "POST /payments" do
    it "returns unauthorized http code (401) when user in not authorized" do
      post "/payments", params: {}, headers: {}

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns forbidden http code (403) when user is authorized but the merchant is inactive" do
      user = create(:user)
      merchant = create(:merchant, status: "inactive")
      user.signed_id(expires_in: 5.minutes)

      post "/payments", params: { merchant_id: merchant.id, amount: 100 }, headers: { "ACCEPT" => "application/json", Authorization: user.signed_id }

      expect(response).to have_http_status(:forbidden)
    end

    it "return unprocessable content http code (422) when user is authorized and merchant is active but amount is missing" do
      user = create(:user)
      merchant = create(:merchant, status: "active")
      user.signed_id(expires_in: 5.minutes)

      post "/payments", params: { merchant_id: merchant.id }, headers: { "ACCEPT" => "application/json", Authorization: user.signed_id }

      expect(response).to have_http_status(:unprocessable_content)
    end

    # in a real implementation we will have all the edge cases captured - cvv missing, date missing, etc...

    # TODO 400 for a bad request (e.g. malformed json)

    it "returns http success when payment is valid" do
      user = create(:user)
      merchant = create(:merchant, status: "active")
      user.signed_id(expires_in: 5.minutes)

      expect {
        post "/payments", params: { merchant_id: merchant.id, customer_email: "a@a.a", amount: 100, status: "approved", type: 'Transactions::Authorize' }, headers: { "ACCEPT" => "application/json", Authorization: user.signed_id }, as: :json
      }.to change { Transaction.count }.by(1)

      expect(response).to have_http_status(:success)
    end
  end
end
