class CreateGameGenres < ActiveRecord::Migration
  def change
    create_table :game_genres do |t|
      t.integer :game_id
      t.string :genre

      t.timestamps null: false
    end
    add_index :game_genres, :game_id
  end
end
