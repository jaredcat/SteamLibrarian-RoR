class User < ActiveRecord::Base
  has_many :users_games
  before_save {self.steamid = User.check_id(steamid)}
  validates :steamid, presence: true, length: {minimum: 17}
  
  
  def self.check_id(steamid)
    if(steamid.to_i.to_s == steamid.to_s && steamid.to_s.length == 17)
      return steamid.to_s
    else
      return Steam::User.vanity_to_steamid(steamid)
    end
  end
  
  
  def self.newUser(steamid)
    user = User.new
    user.steamid = User.check_id(steamid)
    user.steam_level = Steam::Player.steam_level(user.steamid)
    #user.profile_pic = 
    if user.save
      UsersGame.add(user.id, Steam::Player.owned_games(user.steamid, params:{include_appinfo:1}))
    end
  end
end
