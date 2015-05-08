class HomeController < ApplicationController
  def index
    @user = nil
    @errors = (params[:error])
  end
  
  def submit
    if params[:steamid] == ""
      error = ["nousername"]
      redirect_to action: "index", error: error
    else
      steamid = User.checkVanity(params[:steamid])
      if(steamid)
        redirect_to action: "user", steamid: steamid
      else
        error = ["invalidid"]
        redirect_to action: "index", error: error
      end
    end
  end
  
  def user
    params[:update] ? update = true : update = false
    @user = User.checkUser(params[:steamid], update)
    if not @user
      error = ["invalidid"]
      redirect_to action: "index", error: error
    elsif @user == "private"
      @user = nil
      error = ["private"]
      redirect_to action: "index", error: error
    else
      
      #@usersgames = UsersGame.where(user_id: @user.id)
      #@gamelist = Game.where(id: @usersgames.pluck(:game_id)).order("LOWER(name) ASC")
      @gamelist = Game.includes(:users_games).where(users_games: {user_id: @user.id}).order("LOWER(name) ASC")
      
      if params[:misc] != nil
        @checked_misc = params[:misc]
        params[:misc].each do |misc|
          if misc == "Never Played"
            @neverplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever = ?", 0).pluck(:game_id))
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
      
      @neverplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever = 0").pluck(:game_id)) if @neverplayed == nil
      @onlyplayed = Game.where(id: UsersGame.where(game_id: @gamelist).where("playtime_forever != 0").pluck(:game_id)) if @onlyplayed == nil
      
      @misc = [["Never Played", @neverplayed.length], ["Only Played", @onlyplayed.length]]
      @genres = {}
      @themes = {}
      @concepts = {}
      @gamelist.each do |game|
        game.game_genres.each do |genre|
          @genres[genre.genre] != nil ? @genres[genre.genre] += 1 : @genres[genre.genre] = 1
        end
        game.game_themes.each do |theme|
          @themes[theme.theme] != nil ? @themes[theme.theme] += 1 : @themes[theme.theme] = 1
        end
        game.game_concepts.each do |concept|
          @concepts[concept.concept] != nil ? @concepts[concept.concept] += 1 : @concepts[concept.concept] = 1
        end
      end
      @genres = @genres.sort_by {|genre, count| genre}
      @themes = @themes.sort_by {|theme, count| theme}
      @concepts = @concepts.sort_by {|concept, count| concept}
    end
  end
  
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
