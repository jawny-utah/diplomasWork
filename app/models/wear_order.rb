class WearOrder < ApplicationRecord
  belongs_to :order
  belongs_to :wear
  has_many :wear_order_detail_sizes, dependent: :destroy

  accepts_nested_attributes_for :wear_order_detail_size

  before_save :validate_wear_uniqueness_for_order

  enum classic_size: ["44-46/170-176", "48-50/180-186", "52-54/182-188", "56-58/186-192", "60-62/190-196"]

  private

  def validate_wear_uniqueness_for_order
    existing_wear_order = order.wear_orders.find_by(wear_id: id, classic_size: classic_size)
    if existing_wear_order.present?
      existing_wear_order.update(quantity: existing_wear_order.quantity + quantity)
      return false
    end
  end
end
