class AddUserReviewsScoreColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :reviews_score, :integer
    add_column :games, :user_reviews_score, :integer
    remove_column :games, :review_score, :integer
  end
end
