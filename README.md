`rake db:create`
`rake db:migrate`
In rails console to test ttt:

```
def assert_equal(a,b)
  p a == b
end

u=UltimateGame.create
assert_equal u.current_player,"x"
u.take_turn(0,4) #board, cell
assert_equal u.get_boards[0].x, [4]
assert_equal u.current_player, "o"
assert_equal u.current_subgame, 4
assert_equal u.take_turn(0,4), "Not playing in correct game"
u.take_turn(4,4)
assert_equal u.get_boards[0].o, [4]
assert_equal u.current_player, "x"
u.take_turn(4,6)
assert_equal u.current_player, "o"
u.take_turn(6,4)
assert_equal u.current_player, "x"
u.take_turn(4,3)
assert_equal u.current_player, "o"
u.take_turn(3,4)
assert_equal u.subgames_completed, []
assert_equal u.current_player, "x"
u.take_turn(4,0)
assert_equal u.subgames_completed, [["x", 4]] 

```
