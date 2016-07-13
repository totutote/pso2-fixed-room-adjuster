class AddShortUrlToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :short_url, :string
  end
end
