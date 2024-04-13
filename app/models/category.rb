class Category < ApplicationRecord
  has_many :wear_subcategories, through: :subcategories
  has_many :wears, through: :wear_subcategories
  has_many :subcategories, dependent: :destroy
  validates :title, uniqueness: true
end
