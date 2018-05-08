class AddUltimateGameToBoards < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :ultimate_game, foreign_key: true
  end
end
