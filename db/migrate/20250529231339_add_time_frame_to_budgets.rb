class AddTimeFrameToBudgets < ActiveRecord::Migration[8.0]
  def change
    add_column :budgets, :time_frame, :integer, null: false, default: 0
  end
end
