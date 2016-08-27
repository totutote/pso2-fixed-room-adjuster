class CreateUserAuth < ActiveRecord::Migration[5.0]
  def change
    create_table :user_auths do |t|
      t.references :user
      t.string :uid
      t.string :provider

      t.timestamps
    end

    add_index :user_auths, [:uid, :provider], unique: true
  end
end
