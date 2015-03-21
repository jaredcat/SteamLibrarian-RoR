class User < ActiveRecord::Base
  has_many :users_games
end
