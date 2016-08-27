class AddShipNoAndOtherToPlayerCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :player_characters, :ship_number, :integer
    add_column :player_characters, :hu_lv, :integer
    add_column :player_characters, :fi_lv, :integer
    add_column :player_characters, :ra_lv, :integer
    add_column :player_characters, :gu_lv, :integer
    add_column :player_characters, :fo_lv, :integer
    add_column :player_characters, :te_lv, :integer
    add_column :player_characters, :br_lv, :integer
    add_column :player_characters, :bo_lv, :integer
    add_column :player_characters, :su_lv, :integer
  end
end
