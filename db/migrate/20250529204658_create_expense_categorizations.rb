class CreateExpenseCategorizations < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_categorizations do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :expense_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
