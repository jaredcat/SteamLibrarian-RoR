class AddGameAmountToUser < ActiveRecord::Migration
  def change
    add_column :users, :game_count, :integer
  end
end
