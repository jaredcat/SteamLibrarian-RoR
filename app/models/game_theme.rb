class GameTheme < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_id, themes)
  end
end
