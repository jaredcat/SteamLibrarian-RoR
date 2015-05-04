class GameGenre < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_genres)
    genres = []
    game_genres.each do |game_genre|
      game_genre[1].each do |genre|
        genres << GameGenre.new(game_id: game_genre[0], genre: genre['name'])
      end
    end
    GameGenre.import genres
  end
end
