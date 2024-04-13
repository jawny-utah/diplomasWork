class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :wear_subcategories
  has_many :wears, through: :wear_subcategories
  validates :title, uniqueness: true
end
