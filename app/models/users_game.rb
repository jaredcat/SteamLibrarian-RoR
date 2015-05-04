class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user
    
    # checks if a all the user's games are associated with a user
    def self.checkUsersGames(user_id, games)
        count = 0
        owned_games = Steam::Player.owned_games(user.steamid, params:{include_appinfo: 1})
        # if users game count is unchanged, then no reason to check games
        #if(user.game_count != owned_games['game_count'])
            # checkGame finds the game or adds it to our table.
            game_ids = Game.checkGames(owned_games['games'])
            # if the game isnt associated with the user then add it.
            if(game_ids.any?)
                count = UsersGame.add(user, game_ids, owned_games['games'])
            end
            user.game_count = count
            user.save
        #else
        #end
    end

    def self.add(user_id, game_id, game)
        usersgame = UsersGame.where(user_id: user_id, game_id: game_id).first_or_create
        usersgame.user_id = user_id
        usersgame.game_id = game_id
        usersgame.playtime_forever = game['playtime_forever']
        usersgame.playtime_2weeks = game['playtime_2weeks']
        usersgame.save
        return usersgame
    end
    

    def self.updatePlaytime(user_id, game_id, game)
        usersgame = UsersGame.find_by(user_id: user_id, game_id: game_id)
        usersgame.playtime_forever = game['playtime_forever']
        usersgame.playtime_2weeks = game['playtime_2weeks']
        usersgame.save
        return usersgame
    end
    
    def self.delete(id)
        usersgame =  UsersGame.find_by(id)
        usersgame.destroy
    end
end