FactoryBot.define do
  factory :transaction, class: "Transactions::Authorize" do
    amount { 13534 }
    status { :approved }
    merchant { create(:merchant) }
    type { "Transactions::Authorize" }
    customer_email { "hi@minipay.com" }
    customer_phone { "+420 722 234 092" }
  end

  factory :authorize_transaction, class: 'Transactions::Authorize' do
    # Root transaction, no parent needed
    amount { 1223 }
    customer_email { "hi@minipay.com" }
    merchant { create(:merchant) }
    status { :approved }
  end

  factory :charge_transaction, class: 'Transactions::Charge' do
    association :parent, factory: :authorize_transaction
    amount { 1223 }
    customer_email { "hi@minipay.com" }
    merchant { create(:merchant) }
    status { :approved }
  end

  factory :refund_transaction, class: 'Transactions::Refund' do
    association :parent, factory: :charge_transaction
    amount { 1223 }
    customer_email { "hi@minipay.com" }
    merchant { create(:merchant) }
    status { :approved }
  end

  factory :reversal_transaction, class: 'Transactions::Reversal' do
    association :parent, factory: :authorize_transaction
    amount { 1223 }
    customer_email { "hi@minipay.com" }
    merchant { create(:merchant) }
    status { :approved }
  end
end
