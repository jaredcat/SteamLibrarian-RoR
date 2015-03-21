class CreateGameGenres < ActiveRecord::Migration
  def change
    create_table :game_genres do |t|
      t.integer :game_id
      t.string :genre

      t.timestamps null: false
    end
    add_index :game_genres, :game_id
    add_index :game_genres, :genre
    add_index :game_genres, [:game_id, :genre], unique: true
  end
end
