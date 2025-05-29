class ExpenseCategorization < ApplicationRecord
  belongs_to :expense
  belongs_to :expense_category
end
