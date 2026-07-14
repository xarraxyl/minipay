class AddUniqueIndexToTransactionsUuid < ActiveRecord::Migration[8.1]
  def change
    add_index :transactions, :uuid, unique: true
  end
end
