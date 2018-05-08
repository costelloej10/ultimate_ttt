class UltimateGame < ActiveRecord::Base
    before_create :init
    after_create :gen_board
    has_many :boards

    def init
      self.current_subgame = 0
      self.current_player = "x"
      #init these here to make these fields and their starting values visible
      self.game_started = false
      self.player_can_add_any_board = false
    end

    def gen_board
      9.times { |n| self.boards.create!(subgame: n) }
    end

    def take_turn(subgame, cell)
      return "Board not in range" if subgame < 0 || subgame > 8
      game = get_boards[subgame]
      if !self.game_started
        game.take_turn(self.current_player, cell)
        self.update_attributes(:game_started => true)
      elsif get_boards[subgame].winning_player
        return "That board has already been won"
      else  
        if subgame == self.current_subgame || self.player_can_add_any_board#cell in correct subgame
          #check ag ainst if in correct subgame
          #return "Cant play that board" if subgame != self.current_subgame
          game.take_turn(self.current_player, cell)
        else
          return "Not playing in correct game"
        end
      end
      self.update_meta_board(cell)
      self.current_player #return next player
      self.is_meta_game_over
    end

    def is_meta_game_over

    end

    def print_meta_board
      res = []
      get_boards.each do |board|
        res << board.print_board
      end
      res
    end

    def subgames_completed
      res = []
      get_boards.each_with_index do |b, i|
        res << [b.winning_player, i] if b.winning_player
      end
      res
    end

    def update_meta_board(cell)
      next_player = self.current_player == "x" ? "o" : "x"
      self.current_player = next_player
      if get_boards[cell].winning_player
        self.player_can_add_any_board = true 
      else
        self.current_subgame = cell
        self.player_can_add_any_board = false 
      end
      self.save!
    end

    def get_boards
      boards.order(subgame: :asc)
    end
  end    