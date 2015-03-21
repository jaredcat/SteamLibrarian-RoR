class CreateUsersGames < ActiveRecord::Migration
  def change
    create_table :users_games do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps null: false
    end
    add_index :users_games, :game_id
    add_index :users_games, :user_id
    add_index :users_games, [:user_id, :game_id], unique: true
  end
end
