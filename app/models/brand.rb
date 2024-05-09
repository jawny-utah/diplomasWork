class Brand < ApplicationRecord
  has_many :wears
  validates :title, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["wears"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "title", "updated_at"]
  end
end
