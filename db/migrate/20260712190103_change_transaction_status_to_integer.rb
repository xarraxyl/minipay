class ChangeTransactionStatusToInteger < ActiveRecord::Migration[8.1]
  def change
    remove_column :transactions, :status
    add_column :transactions, :status, :integer, default: 0, null: false
  end
end
