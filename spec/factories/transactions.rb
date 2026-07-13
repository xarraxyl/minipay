FactoryBot.define do
  factory :transaction do
    amount { 13534 }
    status { :approved }
    type { "Transactions::Authorize" }
    customer_email { "hi@minipay.com" }
    customer_phone { "+420 722 234 092" }
  end
end
