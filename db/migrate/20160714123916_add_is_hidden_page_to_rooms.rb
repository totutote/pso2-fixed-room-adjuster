class AddIsHiddenPageToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :is_hidden_page, :boolean
  end
end
