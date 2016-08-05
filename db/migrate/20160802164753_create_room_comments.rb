class CreateRoomComments < ActiveRecord::Migration[5.0]
  def change
    create_table :room_comments do |t|
      t.integer :room_id
      t.string :name
      t.string :ident_id
      t.string :comment

      t.timestamps
    end
  end
end
