class Game < ActiveRecord::Base
  has_many :game_concepts
  has_many :game_themes
  has_many :game_genres
  has_many :users_games
  
  def getInfo(game_name)
  
  end
  
  def self.newGame(gameObject, steamID)
    #create new Game entry
    game = Game.new
    game.appid = steamID
    game.gb_id = gameObject['id']
    game.name = gameObject['name']
    game.api_detail_url = gameObject['api_detail_url']
    game.dec = gameObject['deck']
    game.image = gameObject['image']
    game.date_last_updated = gameObject['date_last_updated']
    game.save
  end
  
  def self.updateGame(gameObject)
    #update existing entry
    game = Game.find_by(gb_id: gameObject['id'])
    game.name = gameObject['name']
    game.api_detail_url = gameObject['api_detail_url']
    game.dec = gameObject['deck']
    game.image = gameObject['image']
    game.date_last_updated = gameObject['date_last_updated']
    game.save
  end
  
  def self.deleteGame(gameID)
    #delete existing game object
    game = Game.find_by(id: gameID)
    game.destroy
  end
  
end
