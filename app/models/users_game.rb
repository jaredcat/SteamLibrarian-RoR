class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user
    
    # checks if a all the user's games are associated with a user
    def self.checkUsersGames(user, owned_games)
        count = 0
        # checkGame finds the game or adds it to our table.
        game_ids = Game.checkGames(owned_games['games'])
        # if the game isnt associated with the user then add it.
        if(game_ids.any?)
            count = UsersGame.add(user, game_ids)
        end
        user.game_count = count
        user.save
    end

    def self.add(user, game_ids)
        count = 0
        usersgames = []
        game_ids.each do |game_id|
            if !usersgame = UsersGame.where(user_id: user.id, game_id: game_id[0])
                usersgame.playtime_forever = game_id[1]
                usersgame.playtime_2weeks = game_id[2]
                usersgames << usersgame
            end
            count += 1
        end
        UsersGame.import usersgames
        return count
    end
    
    def self.delete(id)
        usersgame =  UsersGame.find_by(id)
        usersgame.destroy
    end
end