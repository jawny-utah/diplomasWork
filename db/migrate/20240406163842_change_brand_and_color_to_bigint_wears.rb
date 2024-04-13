class ChangeBrandAndColorToBigintWears < ActiveRecord::Migration[7.1]
  def change
    remove_column :wears, :color, :string
    remove_column :wears, :brand, :string
    add_column :wears, :color_id, :bigint
    add_column :wears, :brand_id, :bigint
  end
end
