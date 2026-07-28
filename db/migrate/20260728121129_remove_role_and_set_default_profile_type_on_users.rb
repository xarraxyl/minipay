class RemoveRoleAndSetDefaultProfileTypeOnUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :role, :string

    change_column_default :users, :profile_type, from: nil, to: 'Merchant'
  end
end
