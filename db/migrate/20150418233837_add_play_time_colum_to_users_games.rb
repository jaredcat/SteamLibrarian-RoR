class AddPlayTimeColumToUsersGames < ActiveRecord::Migration
  def change
    add_column :users_games, :time_played, :integer
  end
end
