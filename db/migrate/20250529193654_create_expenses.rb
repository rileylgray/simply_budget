class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false                # e.g., "Groceries", "Rent"
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :category                         # e.g., "Food", "Housing", "Utilities"
      t.date :spent_on, null: false              # Date the expense was made
      t.string :notes                            # Optional notes
      t.integer :frequency, default: 0, null: false # 0: one-time, 1: weekly, 2: monthly, etc.

      t.timestamps
    end
  end
end
