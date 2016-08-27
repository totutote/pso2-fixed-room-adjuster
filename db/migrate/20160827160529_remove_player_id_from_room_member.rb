class RemovePlayerIdFromRoomMember < ActiveRecord::Migration[5.0]
  def change
    remove_column :room_members, :player_id, :integer
  end
end
