class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :crypt_hash
      t.string :salt

      t.timestamps
    end
  end
end
