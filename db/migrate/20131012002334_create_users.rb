class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :phone
      t.string :password
      t.string :user_type
      t.string :role, null: false, default: 'user'

      t.timestamps
    end
  end
end
