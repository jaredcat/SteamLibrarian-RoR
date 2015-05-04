class GameTheme < ActiveRecord::Base
    belongs_to :games
    
  def self.add(game_themes)
    themes = []
    game_themes.each do |game_theme|
      game_theme[1].each do |theme|
        themes << GameTheme.new(game_id: game_theme[0], theme: theme['name'])
      end
    end
    themes.each_slice(25) do |slice|
      GameTheme.import slice
    end
  end
  
  
  def self.update(game_themes)
    game_themes.each do |game_theme|
      game_theme[1].each do |theme|
        GameTheme.where(game_id: game_theme[0], theme: theme['name']).first_or_create
      end
    end
  end
end
