class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, unique: true, null: false
      t.string :email, unique: true, null: false
      t.text :password_digest, null: false
      t.string :phone, limit: 20

      t.timestamps
    end
  end
end
