class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :profile, polymorphic: true, optional: true, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    profile_type == "Admin"
  end

  def merchant?
    profile_type == "Merchant"
  end
end
