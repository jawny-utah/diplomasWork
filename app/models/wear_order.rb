class WearOrder < ApplicationRecord
  belongs_to :order
  belongs_to :wear
  has_many :wear_order_detail_sizes, dependent: :destroy

  accepts_nested_attributes_for :wear_order_detail_sizes, reject_if: proc { |attr| attr["quantity"] == "0" || attr["quantity"].nil? }

  delegate :price, to: :wear, prefix: true

  after_destroy :destroy_order_if_no_wear_order

  validate :size_must_exist, on: :create

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "updated_at", "wear_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order", "wear", "wear_order_detail_sizes"]
  end

  private

  def destroy_order_if_no_wear_order
    order.destroy if order.wear_orders.empty? && order.draft?
  end

  def size_must_exist
    errors.add(:base, "Оберіть розмір") if wear_order_detail_sizes.empty?
  end
end
