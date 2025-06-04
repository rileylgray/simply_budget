class AddColourToCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :expenses, :chart_color, :string
    remove_column :incomes, :chart_color, :string
    add_column :expense_categories, :colour, :string, default: "#F44336"
    add_column :income_categories, :colour, :string, default: "#4CAF50"
  end
end
