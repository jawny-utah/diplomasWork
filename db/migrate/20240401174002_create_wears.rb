class CreateWears < ActiveRecord::Migration[7.1]
  def change
    create_table :wears do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price, null: false
      t.string :brand
      t.string :color
      t.integer :sex

      t.timestamps
    end
  end
end
