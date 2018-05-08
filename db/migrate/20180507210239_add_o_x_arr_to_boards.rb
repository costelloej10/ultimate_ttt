class AddOXArrToBoards < ActiveRecord::Migration[5.0]
  def change
     add_column :boards, :x, :string
     add_column :boards, :o, :string
  end
end
