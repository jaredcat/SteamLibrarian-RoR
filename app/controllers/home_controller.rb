class HomeController < ApplicationController
  def index
    @user = nil
    @error = (params[:error])
  end
  
  def submit
    steamid = User.checkVanity(params[:steamid])
    if(steamid)
      redirect_to action: "user", steamid: steamid
    else
      error = ["Invalid user ID"]
      redirect_to action: "index", error: error
    end
  end
  
  def user
    @user = User.checkUser(params[:steamid])
    if not @user
      error = ["Invalid user ID"]
      redirect_to action: "index", error: error
    elsif @user == "private"
      @user = false
      error = ["Profile set to Private"]
      redirect_to action: "index", error: error
    else
      
      @gamelist = Game.where(id: UsersGame.where(user_id: @user.id).pluck(:game_id)).order("LOWER(name) ASC")
      
      if params[:genres] != nil
        @checked_genres = params[:genres]
        @gamelist &= Game.where(id: GameGenre.where(genre: params[:genres]).pluck(:game_id))
      end
      if params[:themes] != nil
        @checked_themes = params[:themes]
        @gamelist &= Game.where(id: GameTheme.where(theme: params[:themes]).pluck(:game_id))
      end
      if params[:concepts] != nil
        @checked_concepts = params[:concepts]
        @gamelist &= Game.where(id: GameConcept.where(concept: params[:concepts]).pluck(:game_id))
      end
      
      
      @genres = GameGenre.group("genre").where(game_id: @gamelist).order("LOWER(genre) ASC").count("genre")
      @themes = GameTheme.group("theme").where(game_id: @gamelist).order("LOWER(theme) ASC").count("theme")
      @concepts = GameConcept.group("concept").where(game_id: @gamelist).order("LOWER(concept) ASC").count("concept")
    end
  end
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
