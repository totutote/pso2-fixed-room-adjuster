class CreateGroup < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :uuid, :limit => 73
      t.string :name
      t.text :description
      t.boolean :is_hidden_page
    end
  end
end
