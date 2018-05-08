class CreateUltimateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :ultimate_games do |t|
      t.integer :current_subgame
      t.string :current_player
      t.boolean :game_started

      t.timestamps
    end
  end
end
