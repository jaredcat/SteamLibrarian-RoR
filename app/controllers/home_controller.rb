class HomeController < ApplicationController
  def index
  end
  
  def submit
    steamid = User.valid?(params[:steamid])
    if(steamid)
      redirect_to action: "user", steamid: steamid
    else
      redirect_to action: "index"
    end
  end
  
  def user
    @user = User.checkUser(params[:steamid])
    if not @user
      redirect_to action: "index"
    end
    
    @gamelist = Game.where(id: UsersGame.where(user_id: @user.id).pluck(:game_id)).order("LOWER(name) ASC")
    @themes = GameTheme.group("theme").where(id: @gamelist).order("LOWER(theme) ASC").count("theme")
    @concepts = GameConcept.group("concept").where(id: @gamelist).order("LOWER(concept) ASC").count("concept")
    @genres = GameGenre.group("genre").where(id: @gamelist).order("LOWER(genre) ASC").count("genre")
    
    filtered_games = []
    if params[:themes] != nil
      @checked_themes = params[:themes]
      filtered_games += GameTheme.where(theme: params[:themes]).pluck(:game_id)
    end
    if params[:concepts] != nil
      @checked_concepts = params[:concepts]
      filtered_games += GameConcept.where(concept: params[:concepts]).pluck(:game_id)
    end
    if params[:genres] != nil
      @checked_genres = params[:genres]
      filtered_games += GameGenre.where(genre: params[:genres]).pluck(:game_id)
    end
    
    
    if filtered_games != []
      filtered_games = filtered_games.uniq
      @gamelist = Game.where(id: filtered_games).order("LOWER(name) ASC")
    end
  end
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
