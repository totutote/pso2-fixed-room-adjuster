class AddOrganizeInfoToRoomMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :room_members, :room_number, :integer
    add_column :room_members, :party_number, :integer
    add_column :room_members, :is_room_leader, :boolean
    add_column :room_members, :is_party_leader, :boolean
  end
end
