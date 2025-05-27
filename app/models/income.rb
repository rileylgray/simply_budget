class Income < ApplicationRecord
  belongs_to :user

  enum :frequency, { one_time: 0, daily: 1, weekly: 2, biweekly: 3, monthly: 4, yearly: 5 }

  validates :source, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :frequency, presence: true

  # Optional: scope for recent incomes
  scope :recent, -> { order(received_on: :desc) }
end
