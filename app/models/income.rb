class Income < ApplicationRecord
  belongs_to :user

  has_many :income_categorizations, dependent: :destroy
  has_many :income_categories, through: :income_categorizations

  enum :frequency, { one_time: 0, daily: 1, weekly: 2, biweekly: 3, monthly: 4, yearly: 5 }

  validates :source, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :frequency, presence: true

  scope :recent, -> { order(received_on: :desc) }
end
