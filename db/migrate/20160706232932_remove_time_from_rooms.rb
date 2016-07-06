class RemoveTimeFromRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :recruitment_deadline, :time
    remove_column :rooms, :meeting_time, :time
    remove_column :rooms, :quest_start_time, :time
    remove_column :rooms, :quest_end_time, :time
  end
end
