class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user
    
    # checks if a all the user's games are associated with a user
    def self.checkUsersGames(user_id, games)
        count = 0
        user = User.find(user_id)
        # if users game count is unchanged, then no reason to check games
        if(user.game_count != games['game_count'])
            games['games'].each do |game|
                # checkGame finds the game or adds it to our table.
                game_id = Game.checkGame(game['name'], game['appid'])
                # if the game isnt associated with the user then add it.
                if(game_id != nil)
                    UsersGame.add(user_id, game_id, game)
                end
                count += 1
            end
            user.game_count = count
            user.save
        else
            games['games'].each do |game|
                game_id = Game.checkGame(game['name'], game['appid'])
                if(game_id != nil)
                    UsersGame.updatePlaytime(user_id, game_id, game)
                end
            end
        end
    end

    def self.add(user_id, game_id, game)
        usersgame = UsersGame.where(user_id: user_id, game_id: game_id).first_or_create
        usersgame.user_id = user_id
        usersgame.game_id = game_id
        usersgame.playtime_forever = game['playtime_forever']
        usersgame.playtime_forever = game['playtime_2weeks']
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