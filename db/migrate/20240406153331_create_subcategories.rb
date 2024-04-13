class CreateSubcategories < ActiveRecord::Migration[7.1]
  def change
    create_table :subcategories do |t|
      t.belongs_to :category
      t.string :title, null: false

      t.timestamps
    end
  end
end
