class CreateAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.text :description
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
