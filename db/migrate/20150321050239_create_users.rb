class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :steamid
      t.integer :steam_level
      t.string :profile_pic

      t.timestamps null: false
    end
    add_index :users, :id, unique: true
    add_index :users, :steamid, unique: true
  end
end