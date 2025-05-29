class IncomeCategory < ApplicationRecord
  belongs_to :user

  has_many :income_categorizations, dependent: :destroy
  has_many :incomes, through: :income_categorizations

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 255 }, allow_blank: true
end
