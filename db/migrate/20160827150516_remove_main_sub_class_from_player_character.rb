class RemoveMainSubClassFromPlayerCharacter < ActiveRecord::Migration[5.0]
  def change
    remove_column :player_characters, :main_class, :string
    remove_column :player_characters, :sub_class, :string
  end
end
