class Board < ActiveRecord::Base
  belongs_to :ultimate_game

  serialize :o, Array
  serialize :x, Array

  def take_turn(player, position)
    p "Not valid input" and return if position < 0 || position > 8 || !["x", "o"].include?(player) || self.x.include?(position) || self.o.include?(position) #could raise error
    positions = self.send(player)
    positions += [position]
    self.update_attributes(player => positions)
    set_if_game_over
  end

  def set_if_game_over
    check_for_completion("x", self.x) ||
    check_for_completion("o", self.o)
  end

  def print_board
    board_arr = []
    0.upto(8).each do |n|
      if self.x.include?(n)
        board_arr << 'x'
      elsif self.o.include?(n)
        board_arr << 'o'
      else
        board_arr << ''
      end
    end
    board_arr
  end

  def check_for_completion(player, player_coords)
    return if self.winning_player
    #horizontal
    is_completed =  is_complete_line(player_coords, [0,1,2]) || 
                    is_complete_line(player_coords, [3,4,5]) ||
                    is_complete_line(player_coords, [6,7,8]) ||
                    #vertical
                    is_complete_line(player_coords, [0,3,6]) ||
                    is_complete_line(player_coords, [1,4,7]) ||
                    is_complete_line(player_coords, [2,5,8]) ||
                    #diagonal
                    is_complete_line(player_coords, [0,4,8]) ||
                    is_complete_line(player_coords, [2,4,6])
    self.update_attributes(:winning_player => player) if is_completed
    is_completed
  end

  def is_complete_line(player_coords, line_coords)
    (player_coords & line_coords).size == line_coords.size
  end
end
