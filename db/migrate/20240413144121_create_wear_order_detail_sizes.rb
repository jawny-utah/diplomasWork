class CreateWearOrderDetailSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :wear_order_detail_sizes do |t|
      t.belongs_to :wear_order
      t.jsonb :size_details

      t.timestamps
    end
  end
end
