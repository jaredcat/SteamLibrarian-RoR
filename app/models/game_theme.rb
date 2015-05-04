class GameTheme < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_themes)
    themes = []
    game_themes.each do |game_theme|
      game_theme[1].each do |theme|
        themes << GameTheme.new(game_id: game_theme[0].to_i, theme: theme['name'])
      end
    end
    GameTheme.import themes
  end
end
