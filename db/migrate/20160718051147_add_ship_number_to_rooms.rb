class AddShipNumberToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :ship_number, :integer
  end
end
