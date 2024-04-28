class AddTownToShipmentOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :shipment_orders, :customer_town, :string
  end
end
