class RemoveIncomeIdFromIncomeCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :income_categories, :income_id, :bigint
  end
end
