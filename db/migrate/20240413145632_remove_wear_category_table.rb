class RemoveWearCategoryTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :wear_categories
  end
end
