class HomeController < ApplicationController
  def index
    @user = nil
    @errors = (params[:error])
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
      @user = nil
      error = ["Profile set to Private"]
      redirect_to action: "index", error: error
    else
      
      usersgames = UsersGame.where(user_id: @user.id).pluck(:game_id)
      @gamelist = Game.where(id: usersgames).order("LOWER(name) ASC")
      
      if params[:misc] != nil
        @checked_misc = params[:misc]
        params[:misc].each do |misc|
          if misc == "Never Played"
            @neverplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever == ?", 0).pluck(:game_id))
            @gamelist &= @neverplayed
          end
          if misc == "Only Played"
            @onlyplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever != ?", 0).pluck(:game_id))
            @gamelist &= @onlyplayed
          end
        end
      end
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
      
      @neverplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever == ?", 0).pluck(:game_id)) if @neverplayed == nil
      @onlyplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever != ?", 0).pluck(:game_id)) if @onlyplayed == nil
      
      @misc = [["Never Played", @neverplayed.length], ["Only Played", @onlyplayed.length]]
      @genres = GameGenre.where(game_id: @gamelist).order("LOWER(genre) ASC")#.count("genre")
      @themes = GameTheme.where(game_id: @gamelist).order("LOWER(theme) ASC")#.count("theme")
      @concepts = GameConcept.where(game_id: @gamelist).order("LOWER(concept) ASC")#.count("concept")
    end
  end
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
