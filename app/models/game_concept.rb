class GameConcept < ActiveRecord::Base
  belongs_to :games
  
  def self.add(game_concepts)
    concepts = []
    game_concepts.each do |game_concept|
      game_concept[1].each do |concept|
        concepts << GameConcept.new(game_id: game_concept[0].to_i, concept: concept['name'])
      end
    end
    GameConcept.import concepts
  end
end
