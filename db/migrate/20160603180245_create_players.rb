class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :player_id_name
      t.string :nick_name
      t.bool :is_guest_user

      t.timestamps
    end
  end
end
