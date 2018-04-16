class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :role, default: 0
      t.string :password_digest
      t.string :password_confirmation

      t.timestamps
    end
  end
end
