class ShipmentOrder < ApplicationRecord
  belongs_to :order
  validates :customer_phone, phone: true
  validates :customer_phone, :customer_email, :customer_town, :customer_name, presence: true

  enum shipment_type: %i(nova_poshta_post_office nova_poshta_courier)

  SHIPMENT_LOCALIZATION = {
    nova_poshta_post_office: "З відділення 'Нова пошта' - 140 грн.",
    nova_poshta_courier: "Кур'єром 'Нова пошта' - 190 грн."
  }
end
