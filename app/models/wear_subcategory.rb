class WearSubcategory < ApplicationRecord
  belongs_to :wear
  belongs_to :subcategory

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "subcategory_id", "updated_at", "wear_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["subcategory", "wear"]
  end
end
