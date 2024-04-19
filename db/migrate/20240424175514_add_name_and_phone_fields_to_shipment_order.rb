class AddNameAndPhoneFieldsToShipmentOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :shipment_orders, :customer_name, :string
    add_column :shipment_orders, :customer_phone, :string
    add_column :shipment_orders, :customer_email, :string
    remove_column :shipment_orders, :description, :string
    remove_column :shipment_orders, :shipment_type, :string
    add_column :shipment_orders, :shipment_type, :integer
  end
end
