class AddLeaderSettingToRoomMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :room_members, :acceptable_room_leader, :boolean, :after => :player_id
    add_column :room_members, :acceptable_party_leader, :boolean, :after => :acceptable_room_leader
  end
end
