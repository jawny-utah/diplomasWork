class RemoveWearAndQuantityFromOrder < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :wear_id, :bigint
    remove_column :orders, :quantity, :integer
  end
end
