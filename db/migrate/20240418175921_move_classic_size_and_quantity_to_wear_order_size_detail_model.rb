class MoveClassicSizeAndQuantityToWearOrderSizeDetailModel < ActiveRecord::Migration[7.1]
  def change
    remove_column :wear_orders, :classic_size, :integer
    remove_column :wear_orders, :quantity, :integer

    add_column :wear_order_detail_sizes, :classic_size, :integer
    add_column :wear_order_detail_sizes, :quantity, :integer
  end
end
