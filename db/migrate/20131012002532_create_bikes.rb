class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :serial
      t.string :frame_make
      t.string :frame_model
      t.string :color
      t.text :description

      t.string :status, default: "normal", null: false
      t.string :hash_id, null: false
      t.references :user

      t.timestamps
    end
  end
end
