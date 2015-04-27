class User < ActiveRecord::Base
  has_many :users_games
  validates :steamid, presence: true, length: {minimum: 17}
  
  
  def self.valid?(vanity)
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
      # Check if vanity is only numbers by droping letters by converting to int.
      if vanity.to_i.to_s == vanity && vanity.length > 16
        return vanity
      end
    end
    # Returns false or a 17 digit string 
    return steamid
  end
  
  # Checks if a user is new or alreaxy exists
  def self.checkUser(steamid)
    # If user exists
    if(user = User.find_by(steamid: steamid))
      User.updateUser(user)
    else
      return User.newUser(steamid)
    end
    return User.find_by(steamid: steamid)
  end
  
  # Adds a new user to the database
  def self.newUser(steamid)
    user = User.new
    user.steamid = steamid
    user_summary = Steam::User.summary(steamid)
    # If nil we assume that the steam id wasn't a real id, but valid format
    if(user_summary == nil)
      return false
    end
    user.profile_pic = user_summary['avatar']
    user.steam_level = Steam::Player.steam_level(steamid)
    if user.save
      # Associates the user with all the games they own
      UsersGame.checkUsersGames(user.id, 
        Steam::Player.owned_games(steamid, params:{include_appinfo: 1}))
    end
    return user
  end
  
  # Updates an existing user
  def self.updateUser(user)
    getLevel = Steam::Player.steam_level(user.steamid)
    if getLevel != user.steam_level
      user.steam_level = getLevel
    end
    getPic = Steam::User.summary(user.steamid)['avatar']
    if getPic != user.profile_pic
      user.profile_pic = getPic
    end
    if user.save
      # Checks for any new games the user got since they last been here
      UsersGame.checkUsersGames(user.id, 
        Steam::Player.owned_games(user.steamid, params:{include_appinfo: 1}))
    end
  end
end
