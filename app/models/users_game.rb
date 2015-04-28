class UsersGame < ActiveRecord::Base
    belongs_to :games
    belongs_to :user
    
    # checks if a all the user's games are associated with a user
    def self.checkUsersGames(user_id, gamesObject)
        user = User.find(user_id)
        # if users game count is unchanged, then no reason to check games
        if(user.game_count != gamesObject['game_count'])\
            # games are stored in an array
            for index in 0..gamesObject['game_count']-1 do
                current_game = gamesObject['games'][index]
                # checkGame finds the game or adds it to our table.
                game_id = Game.checkGame(current_game['name'], current_game['appid'])
                # if the game isnt associated with the user then add it.
                if not UsersGame.exists?(user_id: user_id, game_id: game_id)
                    UsersGame.add(user_id, game_id, current_game)
                end
            end
            user.game_count = gamesObject['game_count']
            user.save
        end
    end

    def self.add(user_id, game_id, game)
        usersgame = UsersGame.new
        usersgame.user_id = user_id
        usersgame.game_id = game_id
        usersgame.playtime_forever = game['playtime_forever']
        usersgame.playtime_forever = game['playtime_2weeks']
        usersgame.save
    end
    
    # Might add ability to remove games for edge cases
    def self.delete
    end
end