class UserSteamIDtoString < ActiveRecord::Migration
  def change
    change_column :users, :steamid, :string
  end
end
