class WearOrderDetailSize < ApplicationRecord
  belongs_to :wear_order
  store :size_details, accessors: %i(cloth_length shoulders_length chest_size
                                     arms_length arms_width belt_length thighs_length inner_seam_length)

  enum classic_size: ["44-46/170-176", "48-50/180-186", "52-54/182-188", "56-58/186-192", "60-62/190-196"]

  validates :quantity, numericality: { greater_than: 0 }
  validates :cloth_length, :shoulders_length, :chest_size, :arms_length, :arms_width,
            :belt_length, :thighs_length, :inner_seam_length, numericality: { greater_than: 0, less_than: 300 }, allow_blank: true
  validate :classic_size_or_detail_size_should_be_present

  delegate :wear, to: :wear_order

  before_destroy :destroy_wear_order_if_no_size

  WEAR_TYPE_MAPPING = {
    "Куртки": %i[cloth_length shoulders_length chest_size arms_length arms_width],
    "Жилети": %i[cloth_length shoulders_length chest_size],
    "Шорти": %i[belt_length thighs_length cloth_length inner_seam_length],
    "Штани": %i[belt_length thighs_length cloth_length inner_seam_length],
    "Костюми": %i[cloth_length thighs_length inner_seam_length arms_length arms_width]
  }.with_indifferent_access

  def order_price
    quantity * wear_order.wear_price
  end

  private

  def destroy_wear_order_if_no_size
    wear_order.destroy if wear_order.wear_order_detail_sizes.count == 1
  end

  def classic_size_or_detail_size_should_be_present
    errors.add(:base, "Розмір повинен бути присутній") if classic_size.nil? && size_details.empty?
  end
end
