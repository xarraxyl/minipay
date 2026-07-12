class Transaction < ApplicationRecord
  UUID_REGEX = /\A\h{8}-\h{4}-(\h)\h{3}-[89ab]\h{3}-\h{12}\z/i

  after_initialize :defaults

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :uuid, presence: true, uuid: true

  private

  def defaults
    self.uuid ||= SecureRandom.uuid
  end
end
