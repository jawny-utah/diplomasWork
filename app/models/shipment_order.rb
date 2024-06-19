class ShipmentOrder < ApplicationRecord
  belongs_to :order
  validates :customer_phone, phone: true
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :customer_phone, :customer_email, :customer_town, :customer_name, presence: true

  attr_accessor :current_user_id

  enum shipment_type: %i(nova_poshta_post_office nova_poshta_courier)

  SHIPMENT_LOCALIZATION = {
    nova_poshta_post_office: "З відділення 'Нова пошта' - 140 грн.",
    nova_poshta_courier: "Кур'єром 'Нова пошта' - 190 грн."
  }

  validate :user_should_be_loggined_if_exists

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_email", "customer_name", "customer_phone", "customer_town", "delivery_status", "id", "id_value", "order_id", "shipment_type", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order"]
  end

  private

  def user_should_be_loggined_if_exists
    return if current_user_id.present?

    errors.add(:base, "Користувач з введеним email вже зареєстрований, будь ласка, увійдіть в аккаунт.") if find_user_by_email
    errors.add(:base, "Користувач з введеним телефоном вже зареєстрований, будь ласка, увійдіть в аккаунт.") if find_user_by_phone
  end

  def find_user_by_email
    User.find_by(email: customer_email)
  end

  def find_user_by_phone
    User.find_by(phone_number: customer_phone)
  end
end
