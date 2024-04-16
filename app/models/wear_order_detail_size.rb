class WearOrderDetailSize < ApplicationRecord
  belongs_to :wear_order
  store :size_details, accessors: %i(cloth_length shoulders_length chest_size
                                     arms_length arms_width belt_length thighs_length inner_seam_length)

  WEAR_TYPE_MAPPING = {
    "Куртки": %i[cloth_length shoulders_length chest_size arms_length arms_width],
    "Жилети": %i[cloth_length shoulders_length chest_size],
    "Шорти": %i[belt_length thighs_length cloth_length inner_seam_length],
    "Штани": %i[belt_length thighs_length cloth_length inner_seam_length],
    "Костюми": %i[cloth_length thighs_length inner_seam_length arms_length arms_width]
  }.with_indifferent_access
end
