class CreateGameConcepts < ActiveRecord::Migration
  def change
    create_table :game_concepts do |t|
      t.integer :game_id
      t.string :concept

      t.timestamps null: false
    end
    add_index :game_concepts, :game_id
    add_index :game_concepts, :concept
    add_index :game_concepts, [:game_id, :concept], unique: true
  end
end
