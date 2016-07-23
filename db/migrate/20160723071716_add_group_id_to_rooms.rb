class AddGroupIdToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :group_id, :integer
  end
end
