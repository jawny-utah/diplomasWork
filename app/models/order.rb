class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_one :shipment_order
  has_many :wear_orders, dependent: :destroy

  enum payment_type: %i(post_office_payment details_payment)
  enum status: %i(draft created paid processing shipped done canceled)

  accepts_nested_attributes_for :wear_orders, :shipment_order

  after_update :destroy_order_if_no_wear_orders

  PAYMENT_LOCALIZATION = {
    post_office_payment: "Післяплата на 'Нова Пошта'",
    details_payment: "Оплата за реквізитами"
  }

  def total_price
    wear_orders.sum { |wear_order| wear_order.wear_order_detail_sizes.sum(&:order_price) }
  end

  def total_wear_count
    wear_orders.sum { |wear_order| wear_order.wear_order_detail_sizes.sum(&:quantity) }
  end

  def wear_orders_attributes=(wear_orders_attributes)
    wear_orders_attributes.each do |i, attr|
      existing_wear_order = wear_orders.find_by(wear_id: attr["wear_id"])
      if existing_wear_order.present?
        attr["wear_order_detail_sizes_attributes"].each do |i, size_attr|
          next if size_attr["quantity"] == "0"

          if size_attr["classic_size"]
            existing_size_to_update_quantity = existing_wear_order.wear_order_detail_sizes.find_by(classic_size: size_attr["classic_size"])
          else
            existing_size_to_update_quantity = existing_wear_order.wear_order_detail_sizes.find_by(size_details: size_attr.except(:quantity))
          end

          if existing_size_to_update_quantity.present?
            existing_size_to_update_quantity.update(quantity: existing_size_to_update_quantity.quantity + size_attr["quantity"].to_i)
          else
            existing_wear_order.wear_order_detail_sizes.create(size_attr)
          end
        end
      else
        self.wear_orders.build(attr)
      end
    end
  end

  private

  def destroy_order_if_no_wear_orders
    self.destroy if wear_orders.empty?
  end
end
