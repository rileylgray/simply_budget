class CreateIncomeCategorizations < ActiveRecord::Migration[8.0]
  def change
    create_table :income_categorizations do |t|
      t.references :income, null: false, foreign_key: true
      t.references :income_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
