class CreateIncomes < ActiveRecord::Migration[8.0]
  def change
    create_table :incomes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source                # e.g., "Job", "Freelance", "Investments"
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.date :received_on            # Date the income was received
      t.string :notes                # Optional notes about the income
      t.integer :frequency, default: 0, null: false # 0: one-time, 1: weekly, 2: monthly, etc.

      t.timestamps
    end
  end
end
