class Transaction < ApplicationRecord
  # Money Rails
  monetize :amount_cents
  monetize :commission_cents

  # Relations
  belongs_to :meeting

  # Enums
  enum status: {
    pending: 0,
    paid: 1,
    failed: 2
  }

  enum refund_status: {
    none: 0,
    pending_refund: 1,
    refunded: 2,
    refund_failed: 3
  }

  # Validations
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
  validates :commission_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates :stripe_payment_id, uniqueness: true, allow_nil: true

  # Callbacks
  before_validation :calculate_commission, on: :create

  # Constants
  COMMISSION_RATE = 0.5 # 50% commission

  private

  def calculate_commission
    self.commission_cents = (amount_cents * COMMISSION_RATE).to_i if amount_cents
  end
end
