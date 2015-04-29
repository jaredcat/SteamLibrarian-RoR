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
    game.gb_id = gameObject['id']
    game.name = gameObject['name']
    game.api_detail_url = gameObject['api_detail_url']
    game.site_detail_url = gameObject['site_detail_url']
    game.deck = gameObject['deck']
    if gameObject['image'] != nil
      game.image = gameObject['image']['icon_url']
    end
    game.date_last_updated = gameObject['date_last_updated']
    if game.save
      if gameObject['concepts'] != nil
        GameConcept.add(game.id, gameObject['concepts'])
      end
      if gameObject['themes'] != nil
        GameTheme.add(game.id, gameObject['themes'])
      end
      if gameObject['genres'] != nil
        GameGenre.add(game.id, gameObject['genres'])
      end
    end
    return game.id
  end
  
  
  def self.updateGame(game, gameObject)
    #update existing entry
    game.name = gameObject['name']
    game.api_detail_url = gameObject['api_detail_url']
    game.site_detail_url = gameObject['site_detail_url']
    game.deck = gameObject['deck']
    game.image = gameObject['image']['icon_url']
    game.date_last_updated = gameObject['date_last_updated']
    if game.save
      if gameObject['concepts'] != nil
        GameConcept.add(game.id, gameObject['concepts'])
      end
      if gameObject['themes'] != nil
        GameConcept.add(game.id, gameObject['themes'])
      end
      if gameObject['genres'] != nil
        GameConcept.add(game.id, gameObject['genres'])
      end
    end
    return game.id
  end
  
  
  def self.deleteGame(gameID)
    #delete existing game object
    game = Game.find(gameID)
    game.destroy
  end
  
  def self.checkGame(name, appID)
    # Check if the game exists already
    if (game = Game.find_by(appid: appID))
      # Check if the game should be updated
      if game.updated_at > Date.today+30
        # Get info directly from the game
        gameObject = HTTParty.get("http://www.giantbomb.com/api/game/3030-" + game.gb_id.to_s + "/?api_key=" + ENV['GIANTBOMB_API_KEY'] + "&format=json")['results']
        # Return the games db id after updating
        if(gameObject != nil)
          return Game.updateGame(game, gameObject)
        end
      #if row exists but isnt updated, return the row id
      else
        return game.id
      end
    else
      gameObject = GiantBomb::Game.find(name)[0]
      if (gameObject != nil && !Game.exists?(gb_id: gameObject.id))
        game = HTTParty.get("http://www.giantbomb.com/api/game/3030-" + gameObject.id.to_s + "/?api_key=" + ENV['GIANTBOMB_API_KEY'] + "&format=json")['results']
        # return the games db id after updating
        return Game.newGame(game, appID)
      end
    end
    # if the row didnt exist and a new one wasnt created, game should equal nil
    return game
  end
  
end
 