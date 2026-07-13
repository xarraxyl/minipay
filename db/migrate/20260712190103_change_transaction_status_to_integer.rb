class ChangeTransactionStatusToInteger < ActiveRecord::Migration[8.1]
  def change
    change_column :transactions, :status, :integer
  end
end
