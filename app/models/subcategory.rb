class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :wear_subcategories
  has_many :wears, through: :wear_subcategories
  validates :title, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "wear_subcategories", "wears"]
  end
end
