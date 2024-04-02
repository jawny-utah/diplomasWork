class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.integer :role, default: 0
      t.string :address
      t.string :password_digest

      t.timestamps
    end
  end
end
