class AddRoleAndMerchantIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, null: false, default: 1
    add_reference :users, :merchant, null: false, foreign_key: true
  end
end
