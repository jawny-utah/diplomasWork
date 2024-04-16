class CreateWearOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :wear_orders do |t|
      t.belongs_to :wear
      t.belongs_to :order
      t.integer :classic_size
      t.integer :quantity

      t.timestamps
    end
  end
end
