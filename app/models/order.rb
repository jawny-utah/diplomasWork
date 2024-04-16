class Order < ApplicationRecord
  belongs_to :user
  has_one :shipment_order
  has_many :wear_orders, dependent: :destroy

  enum payment_type: %i(post_office_payment details_payment)
  enum status: %i(draft created paid shipped done canceled)

  accepts_nested_attributes_for :wear_orders, reject_if: lambda { |attr| attr["quantity"] == "0" }
end
