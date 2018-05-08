class AddPlayerCanSelectAnyBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :ultimate_games, :player_can_add_any_board, :boolean
  end
end
