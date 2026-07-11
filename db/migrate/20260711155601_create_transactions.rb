class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :uuid
      t.integer :amount
      t.string :status
      t.string :customer_email
      t.string :customer_phone

      t.timestamps
    end
  end
end
