class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user

    def self.add(userid, gamesObject)
        for index in 0..gamesObject['game_count']-1 do
            usersgame = UsersGame.new
            usersgame.user_id = userid
            if(results = Game.exists?(appid: gamesObject['games'][index]['appid']))
                usersgame.game_id = results.id
            else
               newGame = Game.newGame(appid: gamesObject['games'][index]['appid'], name: gamesObject['games'][index]['name'])
               usersgame.game_id = newGame.id
            end
            usersgame.time_played = gamesObject['games'][index]['playtime_forever']
            usersgame.save
        end
    end
end