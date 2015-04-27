class Game < ActiveRecord::Base
  has_many :game_concepts
  has_many :game_themes
  has_many :game_genres
  has_many :users_games
  
  
  def self.getInfo(name, appid)
    game = GiantBomb::Game.find(name)[0]
    Game.newGame(game, appid)
  end
  
  
  def self.newGame(gameObject, steamID)
    #create new Game entry
    game = Game.new
    game.appid = steamID
    game.gb_id = gameObject.id
    game.name = gameObject.name
    game.api_detail_url = gameObject.api_detail_url
    game.deck = gameObject.deck
    game.image = gameObject.image['icon_url']
    game.date_last_updated = gameObject.date_last_updated
    game.save
  end
  
  
  def self.updateGame(gameObject)
    #update existing entry
    game = Game.find_by(gb_id: gameObject.id)
    game.name = gameObject.name
    game.api_detail_url = gameObject.api_detail_url
    game.deck = gameObject.deck
    game.image = gameObject.image['icon_url']
    game.date_last_updated = gameObject.date_last_updated
    game.save
  end
  
  
  def self.deleteGame(gameID)
    #delete existing game object
    game = Game.find(gameID)
    game.destroy
  end
  
  def self.checkGame(name, appID)
    if (Game.exists?(appid: appID))
      gameID = Game.find_by(appid: appID).id
      game = GiantBomb::Game.find(name)[0]
      Game.updateGame(game)
    else
      game = GiantBomb::Game.find(name)[0]
      if (!Game.exists?(gb_id: game.id))
        Game.newGame(game, appID)
      end
      gameID = Game.find_by(gb_id: game.gb_id).id
    end
    return gameID
  end
  
end
