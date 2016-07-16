class AddUuidToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :uuid, :string, :limit => 73
  end
end
