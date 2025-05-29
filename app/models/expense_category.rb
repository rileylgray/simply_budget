class ExpenseCategory < ApplicationRecord
  belongs_to :user

  has_many :expense_categorizations, dependent: :destroy
  has_many :expenses, through: :expense_categorizations

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 255 }, allow_blank: true
end
