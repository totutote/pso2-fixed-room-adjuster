class AddPlayerCharacterIdToRoomMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :room_members, :player_character_id, :integer
  end
end
