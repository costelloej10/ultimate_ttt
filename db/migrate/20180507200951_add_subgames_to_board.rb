class AddSubgamesToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :subgame, :integer
  end
end
