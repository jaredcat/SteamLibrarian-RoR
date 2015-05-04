class GameConcept < ActiveRecord::Base
  belongs_to :games
  
  def self.add(game_concepts)
    concepts = []
    game_concepts.each do |game_concept|
      game_concept[1].each do |concept|
        concepts << GameConcept.new(game_id: game_concept[0], concept: concept['name'])
      end
    end
    concepts.each_slice(25) do |slice|
      GameConcept.import slice
    end
  end
  
  def self.update(game_concepts)
    game_concepts.each do |game_concept|
      game_concept[1].each do |concept|
        GameConcept.where(game_id: game_concept[0], concept: concept['name']).first_or_create
      end
    end
  end
end
