class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user
    
    def self.checkUsersGames(user_id, gamesObject)
        for index in 0..gamesObject['game_count']-1 do
            game_id = Game.checkGame(gamesObject['games'][index]['name'], gamesObject['games'][index]['appid'])
            if not UsersGame.exists?(user_id: user_id, game_id: game_id)
                UsersGame.add(user_id, game_id, gamesObject['games'][index]['playtime_forever'])
            end
        end
    end

    def self.add(user_id, game_id, timeplayedforever)
        usersgame = UsersGame.new
        usersgame.user_id = user_id
        usersgame.game_id = game_id
        usersgame.time_played = timeplayedforever
        usersgame.save
    end
end