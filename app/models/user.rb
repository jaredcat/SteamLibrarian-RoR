class User < ActiveRecord::Base
  has_many :users_games
  validates :steamid, presence: true, length: {minimum: 17}
  
  
  def self.checkVanity(vanity)
    vanity = vanity.to_s
    # Initally false
    steamid = false
    # If vanity doesnt exist do nothing, else resolve steamid
    begin
      steamid = Steam::User.vanity_to_steamid(vanity)
      rescue Steam::SteamError 
    end
    
    # If vanity wasn't resolved, maybe they gave us their SteamID
    if not steamid
      # Converting to int to drop letters and check if vanity was only numbers
      if vanity.length == 17 && vanity.to_i.to_s == vanity
        return vanity
      end
    end
    # Returns false or a 17 digit string 
    return steamid
  end
  
  # Checks if a user is new or already exists
  def self.checkUser(steamid)
    user = User.find_by(steamid: steamid)
    if (user == nil)
      user = User.new
      user.steamid = steamid
    end
    user_summary = Steam::User.summary(user.steamid)
    # If nil it matched the valid format for a steamID it wasn't real
    if(user_summary == nil)
      return false
    #checks for private profiles
    elsif (user_summary['communityvisibilitystate'] < 3)
      return "private"
    end
    user.profile_pic = user_summary['avatar']
    user.steam_level = Steam::Player.steam_level(user.steamid)
    user.profileurl = user_summary['profileurl']
    user.personaname = user_summary['personaname']
    last_update = user.updated_at
    owned_games = Steam::Player.owned_games(user.steamid, params:{include_appinfo: 1})
    # Only update a user every 3 days or if their count isn't correct
    if user.save && ((user.game_count == nil || user.game_count != owned_games['game_count']) && (last_update == nil || last_update > Date.today+3)) 
      # Associates the user with all the games they own
      UsersGame.checkUsersGames(user, owned_games)
    end
    return user
  end
end