class GameTheme < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_id, themes)
    themes.each do |theme|
      GameConcept.where(game_id: game_id, theme: theme['name']).first_or_create
    end
  end
end
