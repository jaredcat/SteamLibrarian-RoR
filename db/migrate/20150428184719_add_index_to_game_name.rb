class AddIndexToGameName < ActiveRecord::Migration
  def change
    add_index :games, :name
    add_column :games, :site_detail_url, :string
    add_column :games, :review_score, :integer
  end
end
