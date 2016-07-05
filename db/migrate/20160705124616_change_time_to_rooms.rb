class ChangeTimeToRooms < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :rooms do |t|
        dir.up   { t.change :recruitment_deadline, :datetime }
        dir.up   { t.change :meeting_time, :datetime }
        dir.up   { t.change :quest_start_time, :datetime }
        dir.up   { t.change :quest_end_time, :datetime }
        dir.down { t.change :recruitment_deadline, :time }
        dir.down { t.change :meeting_time, :time }
        dir.down { t.change :quest_start_time, :time }
        dir.down { t.change :quest_end_time, :time }
      end
    end
  end
end
