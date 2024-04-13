class AddImageToWear < ActiveRecord::Migration[7.1]
  def change
    add_column :wears, :image_name, :string
  end
end
