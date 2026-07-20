class Transaction < ApplicationRecord
  enum :status, { approved: 0, reversed: 1, refunded: 2, error: 3 }

  after_initialize :defaults
  before_validation :check_parent_status, on: :create

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :uuid, presence: true, uuid: true
  validates :customer_email, email: true
  validates :status, presence: true
  validates :type, presence: true
  validate :state_transition_for_status, if: :status_changed?

  belongs_to :merchant
  belongs_to :parent, class_name: "Transaction", optional: true
  has_many :children, class_name: "Transaction", foreign_key: :parent_id

  scope :old, -> { where(created_at: ..1.hour.ago) }

  # Forces Rails routing and view helpers to treat all subclasses
  # (like Transactions::Authorize) as "Transaction". This way we can
  # have only one type of transaction view and routing that handle
  # all child classes.
  def self.model_name
    # Transaction.model_name doesn't work -> recursive function.
    # We need to construct the active model name from scratch
    ActiveModel::Name.new(self, nil, "Transaction")
  end

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

  def check_parent_status
    return if parent.nil?

    # If the parent is NOT approved or refunded the transaction has an error status
    unless parent.approved? || parent.refunded?
      self.status = :error
    end
  end
end
