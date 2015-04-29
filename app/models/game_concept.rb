class GameConcept < ActiveRecord::Base
  belongs_to :games
  
  def self.add(game_id, concepts)
    concepts.each do |concept|
      GameConcept.where(game_id: game_id, concept: concept['name']).first_or_create
    end
  end
end
