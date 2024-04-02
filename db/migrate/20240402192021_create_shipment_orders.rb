class CreateShipmentOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :shipment_orders do |t|
      t.belongs_to :order
      t.string :shipment_type
      t.string :description
      t.integer :delivery_status, default: 0

      t.timestamps
    end
  end
end
