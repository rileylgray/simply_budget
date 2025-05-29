class CreateIncomeCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :income_categories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :income, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
