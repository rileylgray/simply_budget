class CreateExpenseCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_categories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :expense, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
