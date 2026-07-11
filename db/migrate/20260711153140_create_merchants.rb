class CreateMerchants < ActiveRecord::Migration[8.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.string :email
      t.integer :status, default: 1
      t.integer :total_transaction_sum

      t.timestamps
    end
  end
end
