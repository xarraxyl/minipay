FactoryBot.define do
  factory :merchant do
    name { "Minipay Mechant" }
    description { "MyText" }
    email { "MyString" }
    status { 1 }
    total_transaction_sum { 1 }
  end
end
