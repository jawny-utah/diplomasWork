class Material < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "price_per_square_meter", "updated_at"]
  end
end
