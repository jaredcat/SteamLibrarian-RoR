class AddMoreColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :personaname, :string
    add_column :users, :profileurl, :string
    add_column :users_games, :playtime_2weeks, :integer
    change_table :users_games do |t|
      t.rename :time_played, :playtime_forever 
    end
  end
end
