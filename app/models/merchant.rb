class Merchant < ApplicationRecord
  enum :status, { active: 0, inactive: 1 }
  has_many :transactions
end
