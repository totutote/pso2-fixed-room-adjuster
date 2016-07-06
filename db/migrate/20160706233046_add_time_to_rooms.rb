class AddTimeToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :recruitment_deadline, :datetime
    add_column :rooms, :meeting_time, :datetime
    add_column :rooms, :quest_start_time, :datetime
    add_column :rooms, :quest_end_time, :datetime
  end
end
