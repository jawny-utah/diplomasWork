class RemoveMaterials < ActiveRecord::Migration[7.1]
  def change
    drop_table :materials
  end
end
