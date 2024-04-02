class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :wear
      t.integer :quantity, null: false
      t.integer :status, default: 0
      t.integer :payment_type, null: false
      t.string :comment

      t.timestamps
    end
  end
end
