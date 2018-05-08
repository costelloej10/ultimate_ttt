class AddWinningPlayerToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :winning_player, :string
  end
end
