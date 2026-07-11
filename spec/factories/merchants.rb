FactoryBot.define do
  factory :merchant do
    name { "MyString" }
    description { "MyText" }
    email { "MyString" }
    status { 1 }
    total_transaction_sum { 1 }
  end
end
