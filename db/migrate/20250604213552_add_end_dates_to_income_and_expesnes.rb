class AddEndDatesToIncomeAndExpesnes < ActiveRecord::Migration[8.0]
  def change
    add_column :incomes, :end_date, :date
    add_column :expenses, :end_date, :date
    add_column :incomes, :chart_color, :string, default: '#4CAF50' # Default color for income chart
    add_column :expenses, :chart_color, :string, default: '#F44336' # Default color for expense chart

    # Optional: Add indexes for better query performance
    add_index :incomes, :end_date
    add_index :expenses, :end_date
  end
end
