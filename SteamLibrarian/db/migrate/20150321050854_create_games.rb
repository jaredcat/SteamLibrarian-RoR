class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :appid
      t.integer :gb_id
      t.string :name
      t.string :api_detail_url
      t.datetime :date_last_updated
      t.string :dec
      t.string :image

      t.timestamps null: false
    end
    add_index :games, :id, unique: true
    add_index :games, :appid, unique: true
    add_index :games, :gb_id, unique: true
  end
end
