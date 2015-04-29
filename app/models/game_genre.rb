class GameGenre < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_id, genres)
    genres.each do |genre|
      GameGenre.where(game_id: game_id, genre: genre['name']).first_or_create
    end
  end
end
