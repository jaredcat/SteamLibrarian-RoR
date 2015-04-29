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
    @themes = GameTheme.where(id: @gamelist).order("LOWER(theme) ASC").pluck(:theme).uniq
    @concepts = GameConcept.where(id: @gamelist).order("LOWER(concept) ASC").pluck(:concept).uniq
    @genres = GameGenre.where(id: @gamelist).order("LOWER(genre) ASC").pluck(:genre).uniq
    
    filtered_games = nil
    if params[:themes] != nil
      filered_games += GameTheme.where(game_id: @gamelist, theme: params[:themes]).pluck(:game_id)
    end
    if params[:concepts] != nil
      filered_games += GameConcept.where(game_id: @gamelist, concept: params[:concepts]).pluck(:game_id)
    end
    if params[:genres] != nil
      filered_games += GameGenre.where(game_id: @gamelist, genre: params[:genres]).pluck(:game_id)
    end
    
    if filtered_games != nil
      filtered_games = filtered_games.uniq
      @gamelist = filtered_games
    end
  end
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
