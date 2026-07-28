class Merchant < ApplicationRecord
  enum :status, { active: 0, inactive: 1 }
  has_many :transactions, dependent: :restrict_with_error

  # Specific type-based associations using STI classes
  has_many :authorize_transactions, class_name: "Transactions::Authorize"
  has_many :charge_transactions, class_name: "Transactions::Charge"
  has_many :refund_transactions, class_name: "Transactions::Refund"
  has_many :reversal_transactions, class_name: "Transactions::Reversal"

  has_one :user, as: :profile, dependent: :nullify
end
