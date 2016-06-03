class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :room_pass
      t.integer :min_player
      t.integer :max_player
      t.integer :block_no
      t.string :block_place
      t.time :recruitment_deadline
      t.time :meeting_time
      t.time :quest_start_time
      t.time :quest_end_time

      t.timestamps
    end
  end
end
