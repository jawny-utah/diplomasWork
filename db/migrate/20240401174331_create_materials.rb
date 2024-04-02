class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :description
      t.decimal :price_per_square_meter

      t.timestamps
    end
  end
end
