class AddTypeToTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :transactions, :type, :string, null: false
  end
end
