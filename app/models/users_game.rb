class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user

    def self.add(userid, gamesObject)
        for index in 0..gamesObject['game_count']-1 do
            usersgame = UsersGame.new
            usersgame.user_id = userid
            if(results = Game.exists?(appid: gamesObject['games'][index]['appid']))
                #usersgame.game_id = restults.id
            else
                Game.new(appid: gamesObject['games'][index]['appid'])
            end
            usersgame.time_played = gamesObject['games'][index]['playtime_forever']
        end
    end
end