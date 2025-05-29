class Expense < ApplicationRecord
  belongs_to :user

  has_many :expense_categorizations, dependent: :destroy
  has_many :expense_categories, through: :expense_categorizations
  enum :frequency, { one_time: 0, daily: 1, weekly: 2, biweekly: 3, monthly: 4, yearly: 5 }

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :spent_on, presence: true
  validates :frequency, presence: true

  # Optional: scope for recent expenses
  scope :recent, -> { order(spent_on: :desc) }
end
