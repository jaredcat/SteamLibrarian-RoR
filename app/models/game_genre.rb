class GameGenre < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_genres)
    genres = []
    game_genres.each do |game_genre|
      game_genre[1].each do |genre|
        genres << GameGenre.new(game_id: game_genre[0], genre: genre['name'])
      end
    end
    genres.each_slice(25) do |slice|
      GameGenre.import slice
    end
  end
  
  
  def self.update(game_genres)
    game_genres.each do |game_genre|
      game_genre[1].each do |genre|
        GameGenre.where(game_id: game_genre[0], genre: genre['name']).first_or_create
      end
    end
  end
end
