class CreatePlayerCharacterClassSet < ActiveRecord::Migration[5.0]
  def change
    create_table :player_character_class_sets do |t|
      t.references :player_character
      t.string :name
      t.string :main_class
      t.string :sub_class
      t.string :skill_tree
      t.string :weapan

      t.timestamps
    end
  end
end
