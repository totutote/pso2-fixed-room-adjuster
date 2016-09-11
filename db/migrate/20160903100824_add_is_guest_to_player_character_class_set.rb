class AddIsGuestToPlayerCharacterClassSet < ActiveRecord::Migration[5.0]
  def change
    add_column :player_character_class_sets, :is_guest_user, :boolean, default: false
  end
end
