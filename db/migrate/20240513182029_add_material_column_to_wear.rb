class AddMaterialColumnToWear < ActiveRecord::Migration[7.1]
  def change
    add_column :wears, :material, :string
  end
end
