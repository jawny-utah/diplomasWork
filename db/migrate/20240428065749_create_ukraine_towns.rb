class CreateUkraineTowns < ActiveRecord::Migration[7.1]
  def change
    create_table :ukraine_towns do |t|
      t.string :name

      t.timestamps
    end
  end
end
