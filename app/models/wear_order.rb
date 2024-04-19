class WearOrder < ApplicationRecord
  belongs_to :order
  belongs_to :wear
  has_many :wear_order_detail_sizes, dependent: :destroy

  accepts_nested_attributes_for :wear_order_detail_sizes, reject_if: proc { |attr| attr["quantity"] == "0" }

  delegate :price, to: :wear, prefix: true

  after_destroy :destroy_order_if_no_wear_order

  private

  def destroy_order_if_no_wear_order
    order.destroy if order.wear_orders.empty? && order.draft?
  end
end
