FactoryBot.define do
  factory :transaction do
    uuid { "f47ac10b-58cc-4372-a567-0e02b2c3d479" }
    amount { 13534 }
    status { "AuthorizeTransaction" }
    customer_email { "hi@minipay.com" }
    customer_phone { "+420 722 234 092" }
  end
end
