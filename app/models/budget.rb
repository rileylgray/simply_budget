class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :expense_category

  enum :time_frame, { monthly: 0, weekly: 1, daily: 2, yearly: 3 }

  validates :expense_category_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
