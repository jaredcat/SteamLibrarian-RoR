class GameGenre < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_id, genres)
    genres.each do |ge|
      GameConcept.where(game_id: game_id, genres: genres['name']).first_or_create
    end
  end
end
