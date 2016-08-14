class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Omniauthable
      t.string :provider, null: false
      t.string :uid, null: false

      ## Rememberable
      t.datetime :remember_created_at
      t.string   :remember_token

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
