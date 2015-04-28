class GameGenre < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_id, genres)
  end
end
