class Category < ApplicationRecord
  has_many :wear_subcategories, through: :subcategories
  has_many :wears, through: :wear_subcategories
  has_many :subcategories, dependent: :destroy
  validates :title, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["subcategories", "wear_subcategories", "wears"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "title", "updated_at"]
  end
end
