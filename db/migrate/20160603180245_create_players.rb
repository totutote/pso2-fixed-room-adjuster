class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :player_id_name
      t.string :nick_name
      t.boolean :is_guest_user, :null => false, :default => true

      t.timestamps
    end
  end
end
