class User < ActiveRecord::Base
  has_many :users_games
  validates :steamid, presence: true, length: {minimum: 17}
  
  
  def self.valid?(vanity)
    steamid = false
    begin
      steamid = Steam::User.vanity_to_steamid(vanity)
      rescue Steam::SteamError 
    end
    
    return steamid
  end
  
  
  def self.checkUser(steamid)
    if(user = User.find_by(steamid: steamid))
      User.updateUser(user)
    else
      User.newUser(steamid)
    end
    return User.find_by(steamid: steamid)
  end
  
  
  def self.newUser(steamid)
    user = User.new
    user.steamid = steamid
    user.steam_level = Steam::Player.steam_level(steamid)
    user.profile_pic = Steam::User.summary(steamid)['avatar']
    if user.save
      UsersGame.add(user.id, Steam::Player.owned_games(steamid, params:{include_appinfo: 1}))
    end
  end
  
  
  def self.updateUser(user)
    getLevel = Steam::Player.steam_level(user.steamid)
    if getLevel != user.steam_level
      user.steam_level = getLevel
    end
    getPic = Steam::User.summary(user.steamid)['avatar']
    if getPic != user.profile_pic
      user.profile_pic = getPic
    end
    user.save
  end
end
