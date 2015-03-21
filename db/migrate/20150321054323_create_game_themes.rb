class CreateGameThemes < ActiveRecord::Migration
  def change
    create_table :game_themes do |t|
      t.integer :game_id
      t.string :theme

      t.timestamps null: false
    end
    add_index :game_themes, :game_id
    add_index :game_themes, :theme
    add_index :game_themes, [:game_id, :theme], unique: true
  end
end
