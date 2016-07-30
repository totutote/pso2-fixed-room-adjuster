class CreatePlayerCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :player_characters do |t|
      t.integer :player_id
      t.string :name
      t.string :main_class
      t.string :sub_class

      t.timestamps
    end
  end
end
