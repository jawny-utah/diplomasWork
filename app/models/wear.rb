class Wear < ApplicationRecord
  include Filterable

  enum sex: %i(male female)
  has_one :wear_subcategory
  has_one :subcategory, through: :wear_subcategory
  has_one :category, through: :subcategory
  has_many :wear_order, dependent: :destroy
  belongs_to :brand
  belongs_to :color

  scope :by_subcategory, ->(title) { joins(:subcategory).where(subcategory: { title: title }) }
  scope :by_color, ->(title) { joins(:color).where(color: { title: title }) }
  scope :by_brand, ->(title) { joins(:brand).where(brand: { title: title }) }
  scope :by_sex, ->(sex) { where(sex: sex) }

  def full_name
    [name, brand.title, color.title].join(" ")
  end

  def formatted_price
    [price, "грн."].join(" ")
  end

  def self.ransackable_associations(auth_object = nil)
    ["brand", "category", "color", "subcategory", "wear_order", "wear_subcategory"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "color_id", "created_at", "description", "id", "id_value", "image_name", "name", "price", "sex", "updated_at"]
  end
end
