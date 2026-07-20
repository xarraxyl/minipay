class AddParentToTransactions < ActiveRecord::Migration[8.1]
  def change
    # there are transactions without parents
    add_reference :transactions, :parent, null: true, foreign_key: { to_table: :transactions }
  end
end
