class CreateWearSubcategories < ActiveRecord::Migration[7.1]
  def change
    create_table :wear_subcategories do |t|
      t.belongs_to :wear
      t.belongs_to :subcategory

      t.timestamps
    end
  end
end
