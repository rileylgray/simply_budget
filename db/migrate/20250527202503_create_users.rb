class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest
      t.string :username, index: { unique: true }
      t.string :role
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
