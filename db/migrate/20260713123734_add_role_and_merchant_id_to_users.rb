class AddRoleAndMerchantIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer
    add_reference :users, :merchant, null: false, foreign_key: true
  end
end
