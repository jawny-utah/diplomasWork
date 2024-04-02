class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.string :description, null: false
      t.string :link_to, null: false
      t.boolean :read, default: 0

      t.timestamps
    end
  end
end
