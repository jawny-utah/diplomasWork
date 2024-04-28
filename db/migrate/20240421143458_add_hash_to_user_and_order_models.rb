class AddHashToUserAndOrderModels < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uniq_hash, :string
    add_column :orders, :uniq_user_hash, :string
  end
end
