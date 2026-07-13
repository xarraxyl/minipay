class Transaction < ApplicationRecord
  UUID_REGEX = /\A\h{8}-\h{4}-(\h)\h{3}-[89ab]\h{3}-\h{12}\z/i

  enum :status, { approved: 0, reversed: 1, refunded: 2, error: 3 }

  after_initialize :defaults

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :uuid, presence: true, uuid: true
  validates :customer_email, email: true
  validates :status, presence: true
  validate :state_transition_for_status, if: :status_changed?

  private

  def defaults
    self.uuid ||= SecureRandom.uuid
  end

  def state_transition_for_status
    # deals with nil -> anything
    return if self.new_record? or status_was.nil?

    case status_was.to_sym
    when :approved
      # do nothing
    when :reversed, :refunded, :error
      errors.add(:status, :invalid_state_transition, message: "invalid state transition #{status_was} -> #{status}")
    else
      raise "Unknown status for Transaction #{self.inspect}"
    end
  end
end
