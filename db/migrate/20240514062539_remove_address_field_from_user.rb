class RemoveAddressFieldFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :address, :string
  end
end
