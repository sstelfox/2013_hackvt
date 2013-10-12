class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :serial
      t.string :frame_make
      t.string :frame_model
      t.string :size
      t.string :color
      t.string :location_found
      t.references :user

      t.timestamps
    end
  end
end